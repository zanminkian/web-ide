# Web-IDE

![cover](https://raw.githubusercontent.com/zanminkian/static/main/web-ide/cover.jpeg)

[![GitHub license](https://img.shields.io/github/license/zanminkian/web-ide)](https://github.com/zanminkian/web-ide/blob/main/LICENSE)

## What is it?

Web-IDE is a batteries-included, web-based development environment that gives you a complete coding experience right out of the box.

## Features

- Start the IDE with a single command, powered by Docker and [code-server](https://github.com/coder/code-server).
- Access the IDE from any browser and code from any machine, anywhere.
- Pre-installed development toolchains for an out-of-the-box experience:
  - [x] Node (Frontend / Electron)
  - [ ] Go
  - [ ] Python
  - [ ] Java

## Usage

Download the image from [GitHub Releases](https://github.com/zanminkian/web-ide/releases), then run:

```sh
docker load -i your-downloaded-image.tgz
docker run -itd -p 8080:8080 -e PASSWORD=your_password --name web-ide zengmingjian/web-ide
```

Then open `http://localhost:8080` in your browser.

## Advanced Usage

- Append CLI options to `web-ide` at the end of the command:

  ```sh
  docker run -itd --network host -e PASSWORD=your_password --name web-ide zengmingjian/web-ide --bind-addr 0.0.0.0:9090
  ```

- Run `docker run -it --rm zengmingjian/web-ide --help` for all available options.

- To inspect the environment configuration, run `cat ~/.zshrc` inside the container. Feel free to customize it.

- Run `start-desktop` inside the container and visit `http://localhost:6080/vnc.html` to access an Xfce desktop environment.

## FAQ

<details>
<summary>Q: Some shortcuts conflict between web-vscode and the browser. How can I avoid this?</summary>

A: Convert the web vscode into a Progressive Web App (PWA).

</details>

<details>
<summary>Q: Some extensions that use iframes to render their UI don't work properly (e.g., <code>git graph</code>). How can I fix this?</summary>

A: This happens when vscode is accessed in the browser with a non-<code>localhost</code> address and a non-<code>https</code> protocol. Solutions:

- Set up a forward proxy with `ssh -CqTnNfL 8080:127.0.0.1:8080 my-remote-server`, then access vscode via `http://localhost:8080`.
- Open `chrome://flags/#unsafely-treat-insecure-origin-as-secure` in Chrome to trust insecure origins, then access vscode via `http://some-ip-or-domain:8080`.
- Use `https` instead of `http`.

</details>

<details>
<summary>Q: The Docker container can't log in to a remote server via SSH. Why, and how do I fix it?</summary>

A: The remote server likely rejects the `rsa` algorithm for security reasons. Alternatives:

- Generate an SSH key using the `ed25519` algorithm: `ssh-keygen -t ed25519`.
- Add the following to `~/.ssh/config`:

  ```
  Hostname user@your-ip.com
      HostkeyAlgorithms +ssh-rsa
      PubkeyAcceptedAlgorithms +ssh-rsa
      PubkeyAcceptedKeyTypes +ssh-rsa
  ```

</details>

<details>
<summary>Q: <code>apt update</code> or <code>apt install</code> is slow. How can I speed it up?</summary>

A: Run `sudo sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/debian.sources` to switch to a faster mirror. This is particularly useful for users in China.

</details>

<details>
<summary>Q: After running <code>start-desktop</code>, how do I input Chinese characters in the Xfce desktop?</summary>

A: Run `sudo apt update && sudo apt install -y fcitx5 fcitx5-pinyin`, then restart the desktop with `stop-desktop` and `start-desktop`. Finally, right-click the keyboard icon in the top-right corner, select **Configure**, and add **Pinyin** as an input method.

</details>

## Show your support

Give it a ⭐️ if this project helped you!

## License

MIT
