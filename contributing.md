# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test cloudflared https://github.com/threkk/asdf-cloudflared.git "cloudflared -h"
```

Tests are automatically run in GitHub Actions on push and PR.
