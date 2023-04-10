# web-ide

![1](./cover.jpeg)

## What is it?

A web IDE including all tools what you need. Enjoy coding out-of-box.

## Feature

- Start the IDE in one line of command. Powered by docker.
- Access IDE in browser. Code in any machine any where.
- A wealth of development tools make you enjoy coding out-of-box.
  - [x] Go
  - [x] Node
  - [x] React
  - [ ] Java

## Usage

```sh
docker run -itd --net host -e PASSWORD=you_password --name web-ide zengmingjian/web-ide
```

After that, open `http://127.0.0.1:8080` in your browser and input your password. Then, have fun with coding!

> Note that docker in macOS do not support host networking. You need to change `--net host` to `-p 8080:8080`.

## Advanced usage

- Add more cli options for `web-ide` at the end of command.
  ```sh
  docker run -itd --net host -e PASSWORD=you_password --name web-ide zengmingjian/web-ide --bind-addr 0.0.0.0:9090
  ```

- Run `docker run -it --rm zengmingjian/web-ide --help` for more information.

- Run `cat ~/.zshrc` inside a container to check the env config. Feel free to edit it.

## FAQ

> Q: There are some shortcut conflicts between web vscode and browser. How to avoid it?

A: Change web vscode to a PWA.

> Q: Some extensions, which use iframe to render UI, works not properly. Such as `git graph`. How to fix it?

A: The reason is that you are accessing vscode in the browser while the website address is not `localhost` and protocol is not `https`. Here are some solutions.
- Run command `ssh -CqTnNfL 8080:127.0.0.1:8080 my-remote-server` to forward proxy. And then access vscode via `http://localhost:8080`.
- Open link `chrome://flags/#unsafely-treat-insecure-origin-as-secure` in browser to trust insecure origin. And then access vscode via `http://some-ip-or-domain:8080`.
- Use `https` protocol instead of `http` protocol.


## Note

The image built by this repo do not support `rsa` algorithm because it unsafe. There are 2 methods can help.
- Generate your ssh key in `ed25519` algorithm. For example, `ssh-keygen -t ed25519`.
- Add `HostkeyAlgorithms +ssh-rsa\n    PubkeyAcceptedAlgorithms +ssh-rsa\n    PubkeyAcceptedKeyTypes +ssh-rsa` to `~/.ssh/config`. For example, `Hostname user@your-ip.com\n    HostkeyAlgorithms +ssh-rsa\n    PubkeyAcceptedAlgorithms +ssh-rsa\n    PubkeyAcceptedKeyTypes +ssh-rsa\n`

## License

MIT
