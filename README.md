<div align="center">

# asdf-cloudflared [![Build](https://github.com/threkk/asdf-cloudflared/actions/workflows/build.yml/badge.svg)](https://github.com/threkk/asdf-cloudflared/actions/workflows/build.yml) [![Lint](https://github.com/threkk/asdf-cloudflared/actions/workflows/lint.yml/badge.svg)](https://github.com/threkk/asdf-cloudflared/actions/workflows/lint.yml)


[cloudflared](https://developers.cloudflare.com/argo-tunnel/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add cloudflared
# or
asdf plugin add cloudflared https://github.com/threkk/asdf-cloudflared.git
```

cloudflared:

```shell
# Show all installable versions
asdf list-all cloudflared

# Install specific version
asdf install cloudflared latest

# Set a version globally (on your ~/.tool-versions file)
asdf global cloudflared latest

# Now cloudflared commands are available
cloudflared -h
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/threkk/asdf-cloudflared/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Alberto de Murga](https://github.com/threkk/)
