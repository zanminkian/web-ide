# Web-IDE

![cover](https://raw.githubusercontent.com/zanminkian/static/main/web-ide/cover.jpeg)

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

Then visit `http://localhost:8080` in your browser.

## Advanced Usage

- Add more CLI options for `web-ide` at the end of the command.

  ```sh
  docker run -itd --network host -e PASSWORD=your_password --name web-ide zengmingjian/web-ide --bind-addr 0.0.0.0:9090
  ```

- Run `docker run -it --rm zengmingjian/web-ide --help` for more information.

- To check the environment configuration, run `cat ~/.zshrc` inside the container. Feel free to edit it.

- Run `start-desktop` inside the container and visit `http://localhost:6080/vnc.html` to visit a xfce desktop environment.

## FAQ

<details>
<summary>Q: Some shortcuts conflict between web-vscode and the browser. How can I avoid this?</summary>

A: Convert this web vscode into a Progressive Web App (PWA).

</details>

<details>
<summary>Q: Some extensions, which use iframes to render their UI, don't work properly, like <code>git graph</code>. How can I solve this problem?</summary>

A: This issue occurs when you access vscode in the browser with a website address that is not <code>localhost</code> and a protocol that is not <code>https</code>. Here are some solutions:

- Set up a forward proxy with the command <code>ssh -CqTnNfL 8080:127.0.0.1:8080 my-remote-server</code>. Then access vscode via <code>http://localhost:8080</code>.
- Open <code>chrome://flags/#unsafely-treat-insecure-origin-as-secure</code> in your browser to trust insecure origins. Then access vscode via <code>http://some-ip-or-domain:8080</code>.
- Use an <code>https</code> protocol instead of <code>http</code>.

</details>

<details>
<summary>Q: This Docker container is unable to log in to another remote server via SSH. What could be the cause, and how can it be resolved?</summary>

A: Probably, the remote server does not support the <code>rsa</code> algorithm due to security concerns. Here are two alternatives:

- Generate your SSH key using the <code>ed25519</code> algorithm, with <code>ssh-keygen -t ed25519</code>.
- Add <code>HostkeyAlgorithms +ssh-rsa\n PubkeyAcceptedAlgorithms +ssh-rsa\n PubkeyAcceptedKeyTypes +ssh-rsa</code> to <code>~/.ssh/config</code>. For example: <code>Hostname user@your-ip.com\n HostkeyAlgorithms +ssh-rsa\n PubkeyAcceptedAlgorithms +ssh-rsa\n PubkeyAcceptedKeyTypes +ssh-rsa\n</code>

</details>

<details>
<summary>Q: Running <code>apt update</code> or <code>apt install</code> is slow. How to speed up?</summary>
A: Run <code>sudo sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/debian.sources</code> to change the apt source. It's useful for Chinese users.
</details>

<details>
<summary>Q: After running <code>start-desktop</code>, how to input Chinese characters in xfce4 desktop?</summary>
A: Run <code>sudo apt update && sudo apt install -y fcitx5 fcitx5-pinyin</code>. Then run <code>stop-desktop</code> and <code>start-desktop</code> again. Finally, right click the keyboard icon in the top right corner to select <code>Configure</code> and add <code>Pinyin</code> to <code>Input Method</code>.
</details>

## Show your support

Give a ⭐️ if this project helped you!

## License

MIT
