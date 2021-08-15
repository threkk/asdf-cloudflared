#!/usr/bin/env bash

set -euo pipefail

REPORT_URL="https://github.com/threkk/asdf-cloudflared/issues"
GH_REPO="https://github.com/cloudflare/cloudflared"
TOOL_NAME="cloudflared"
TOOL_TEST="cloudflared -h"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  LC_ALL=C sort -r -V
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//'
}

list_all_versions() {
  # Versions prior 2020.5 are not supported.
  list_github_tags | grep --invert-match "201" | grep --invert-match "2020\.[1234]"
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  case $(uname | tr '[:upper:]' '[:lower:]') in
  linux*)
    local platform=linux-amd64
    local ext=""
    ;;
  darwin*)
    local platform=darwin-amd64
    local ext=".tgz"
    ;;
  *)
    fail "Platform download not supported. Please, open an issue at $REPORT_URL"
    ;;
  esac

  url="$GH_REPO/releases/download/${version}/${TOOL_NAME}-${platform}${ext}"

  echo "* Downloading $TOOL_NAME release $version from $url"
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (

    mkdir -p "$install_path/bin"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path/bin/$TOOL_NAME"
    ls -al "$install_path"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
