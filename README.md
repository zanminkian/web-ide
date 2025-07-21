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
  - [x] Node (Frontend/Electron)
  - [ ] Go
  - [ ] Python
  - [ ] Java

## Usage

Download images from [Github Releases](https://github.com/zanminkian/web-ide/releases). Then run commands below:

```sh
docker load -i your-downloaded-image.tgz
docker run -itd -p 8080:8080 -e PASSWORD=your_password --name web-ide zengmingjian/web-ide
```

## Advanced Usage

- Add more CLI options for `web-ide` at the end of the command.

  ```sh
  docker run -itd --net host -e PASSWORD=your_password --name web-ide zengmingjian/web-ide --bind-addr 0.0.0.0:9090
  ```

- Run `docker run -it --rm zengmingjian/web-ide --help` for more information.

- To check the environment configuration, run `cat ~/.zshrc` inside a container. Feel free to edit it.

## Running GUI App via X11

1. Run docker container (`docker run`) with option `-e DISPLAY=host.docker.internal:0`.
2. Install [XQuartz](https://www.xquartz.org/) on Mac.
3. Open XQuartz -> Preferences -> Security. Make sure to enable `Allow connections from network clients`.
4. Run `xhost + localhost` in host (Mac) terminal.
5. Run `apt update && apt install -y gedit && gedit foo.txt` in Web-IDE terminal.
6. `gedit` should be opened on Mac.

## FAQ

<details>
<summary>Q: Some shortcuts conflict between web-vscode and the browser. How can I avoid this?</summary>

A: Convert this web vscode into a Progressive Web App (PWA).

</details>

<details>
<summary>Q: Some extensions, which use iframes to render their UI, don't work properly, like `git graph`. How can I solve this problem?</summary>

A: This issue occurs when you access vscode in the browser with a website address that is not `localhost` and a protocol that is not `https`. Here are some solutions:

- Set up a forward proxy with the command `ssh -CqTnNfL 8080:127.0.0.1:8080 my-remote-server`. Then access vscode via `http://localhost:8080`.
- Open `chrome://flags/#unsafely-treat-insecure-origin-as-secure` in your browser to trust insecure origins. Then access vscode via `http://some-ip-or-domain:8080`.
- Use an `https` protocol instead of `http`.

</details>

<details>
<summary>Q: This Docker container is unable to log in to another remote server via SSH. What could be the cause, and how can it be resolved?</summary>

A: Probably, the remote server does not support the `rsa` algorithm due to security concerns. Here are two alternatives:

- Generate your SSH key using the `ed25519` algorithm, with `ssh-keygen -t ed25519`.
- Add `HostkeyAlgorithms +ssh-rsa\n    PubkeyAcceptedAlgorithms +ssh-rsa\n    PubkeyAcceptedKeyTypes +ssh-rsa` to `~/.ssh/config`. For example: `Hostname user@your-ip.com\n    HostkeyAlgorithms +ssh-rsa\n    PubkeyAcceptedAlgorithms +ssh-rsa\n    PubkeyAcceptedKeyTypes +ssh-rsa\n`

</details>

## Show your support

Give a ⭐️ if this project helped you!

## License

MIT
