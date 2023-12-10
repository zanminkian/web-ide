# Web-IDE

![cover](https://raw.githubusercontent.com/zanminkian/static/main/web-ide/cover.jpeg)

[![Docker](https://img.shields.io/docker/v/zengmingjian/web-ide)](https://hub.docker.com/r/zengmingjian/web-ide)
[![GitHub license](https://img.shields.io/github/license/zanminkian/web-ide)](https://github.com/zanminkian/web-ide/blob/main/LICENSE)

## What is it?

Web-IDE is a comprehensive web-based integrated development environment (IDE) that includes all the tools you need for an enjoyable coding experience, out-of-the-box.

## Features

- Start the IDE with a single command line, powered by Docker and [code-server](https://github.com/coder/code-server).
- Access IDE through your browser and code from any machine, anywhere.
- A wealth of pre-installed development tools for an out-of-the-box coding experience:
  - [x] Node (including frontend development tool chain)
  - [x] Go
  - [ ] Python
  - [ ] Java

## Usage

```sh
docker run -itd -p 8080:8080 -e PASSWORD=your_password --name web-ide zengmingjian/web-ide
```

After running the command, open `http://127.0.0.1:8080` in your browser, enter your password and start coding!

> Note: If you are using macOS, mounting volume will be unstable to use pnpm. Check [this issue](https://github.com/pnpm/pnpm/issues/5803). The workaround is setting the container file sharing to `gRPC FUSE` implementation. Check [this comment](https://github.com/pnpm/pnpm/issues/5803#issuecomment-1694241533).

## Advanced Usage

- Add more CLI options for `web-ide` at the end of the command.

  ```sh
  docker run -itd --net host -e PASSWORD=your_password --name web-ide zengmingjian/web-ide --bind-addr 0.0.0.0:9090
  ```

- Run `docker run -it --rm zengmingjian/web-ide --help` for more information.

- To check the environment configuration, run `cat ~/.zshrc` inside a container. Feel free to edit it.

## FAQ

> Q: Some shortcuts conflict between web-vscode and the browser. How can I avoid this?

A: Convert this web vscode into a Progressive Web App (PWA).

> Q: Some extensions, which use iframes to render their UI, don't work properly, like `git graph`. How can I solve this problem?

A: This issue occurs when you access vscode in the browser with a website address that is not `localhost` and a protocol that is not `https`. Here are some solutions:

- Set up a forward proxy with the command `ssh -CqTnNfL 8080:127.0.0.1:8080 my-remote-server`. Then access vscode via `http://localhost:8080`.
- Open `chrome://flags/#unsafely-treat-insecure-origin-as-secure` in your browser to trust insecure origins. Then access vscode via `http://some-ip-or-domain:8080`.
- Use an `https` protocol instead of `http`.

> Q: This Docker container is unable to log in to another remote server via SSH. What could be the cause, and how can it be resolved?

A: Probably, the remote server does not support the `rsa` algorithm due to security concerns. Here are two alternatives:

- Generate your SSH key using the `ed25519` algorithm, with `ssh-keygen -t ed25519`.
- Add `HostkeyAlgorithms +ssh-rsa\n    PubkeyAcceptedAlgorithms +ssh-rsa\n    PubkeyAcceptedKeyTypes +ssh-rsa` to `~/.ssh/config`. For example: `Hostname user@your-ip.com\n    HostkeyAlgorithms +ssh-rsa\n    PubkeyAcceptedAlgorithms +ssh-rsa\n    PubkeyAcceptedKeyTypes +ssh-rsa\n`

## Show your support

Give a ⭐️ if this project helped you!

## License

MIT
