## Project overview

Web-IDE is a Docker-based web IDE that bundles [code-server](https://github.com/coder/code-server) with pre-installed development tools. The Docker image is published as `zengmingjian/web-ide` for both `linux/amd64` and `linux/arm64`.

## Commands

```sh
pnpm test           # Node built-in test runner + fenge style check
pnpm run style      # fenge style check only
pnpm run style:update  # fenge auto-fix
```

## Architecture

The Docker image is built in four stages (see `src/Dockerfile`):

1. **Base** — Debian with zsh, curl, git, vim, sudo installed.
2. **Install** (`src/install/`) — Run as **root**. Each `*.sh` file installs a tool. Executed in alphabetical order by `install.sh`:
   - `cli.sh` — build-essential and other apt packages
   - `code-server.sh` — code-server binary + `/usr/bin/code` wrapper with custom marketplace URL
   - `node.sh` — [jrm](https://github.com/rnmjs/jrm) runtime manager (used later to install Node LTS versions)
   - `python.sh` — Python 3
   - `xfce.sh` — Xfce4 desktop, TigerVNC, noVNC, Chromium, `start-desktop`/`stop-desktop` scripts
3. **Setup** (`src/setup/`) — Run as the **web-ide user**. Each `*.sh` configures the user environment. Executed in alphabetical order by `setup.sh`:
   - `code-server.sh` — VS Code extensions + settings.json + code-server config
   - `node.sh` — installs all maintaining Node LTS versions via jrm, global npm packages, Claude Code
   - `omz.sh` — **Must run last** (validated by test). Installs Oh My Zsh, prepends its config to `~/.zshrc`, then appends the previous `.zshrc` content.
4. **Entrypoint** — `src/scripts/bootstrap` (pid 1): injects SSH keys / git config / env vars from `WI_*` environment variables via `web-ide-init`, sets the `web-ide` user password, then launches code-server.
