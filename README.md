# code-server

![1](./cover.jpeg)

## What is it?

Build you developing environment in docker and access VSCode in browser.

The developing environment includes the following tool chain:
- [x] Go
- [x] Node
- [x] React
- [ ] Java

Build docker image -> Run as docker container -> Enjoy developing in browser.

## Usage

### 1. Build docker image

1. Clone this repo.
2. Enter the dir of this repo.
3. Build it. The build script looks like this:

```bash
docker build -t code-server:1.0.0 .
```

### 2. Run docker container

After building image, you can run it.

```sh
docker run -itd --net host -e PASSWORD=xxx --name code-server code-server:1.0.0
```

Add `-v` if you need it. For example:

```sh
docker run -itd --net host -e PASSWORD=xxx -v $HOME/projects:/root/projects -v $HOME/.ssh:/root/.ssh -v $HOME/.gitconfig:/root/.gitconfig -v $HOME/.zsh_history:/root/.zsh_history -v $HOME/.go:/root/go --name code-server code-server:1.0.0
```

> Note that docker in macOS do not support host networking. You need to change `--net host` to `-p 8080:8080`.

### 3. Access web VSCode in browser

Visit `http://localhost:8080` , you can open the VSCode editor in your browser.

## Advanced usage

- You can add more cli options for `code-server` at the end of command in __Step 2__.
    ```sh
    docker run -itd --net host -e PASSWORD=xxx -v $HOME/projects:/root/projects -v $HOME/.ssh:/root/.ssh -v $HOME/.gitconfig:/root/.gitconfig -v $HOME/.zsh_history:/root/.zsh_history -v $HOME/.go:/root/go --name code-server code-server:1.0.0 --bind-addr 0.0.0.0:8080 --disable-update-check --disable-getting-started-override --disable-workspace-trust
    ```
- Just add more installer scripts to `installers` folder or remove any built-in installer scripts in `installers` folder as you want.

## FAQ

> Q: There are some shortcut conflicts between web vscode and browser. How to avoid it?

A: Change web vscode to a PWA.

> Q: Some extensions, which use iframe to render UI, works not properly. Such as `git graph`. How to fix it.

A: The reason is that you are accessing vscode in the browser while the website address is not `localhost` and protocol is not `https`. Here are some solutions.
- Run command `ssh -CqTnNfL 8080:127.0.0.1:8080 my-remote-server` to forward proxy. And then access vscode via `http://localhost:8080`.
- Open link `edge://flags/#unsafely-treat-insecure-origin-as-secure` in browser to trust insecure origin. And then access vscode via `http://some-ip-or-domain:8080`.
- Use `https` protocol instead of `http` protocol.


## Note

The image built by this repo do not support `rsa` algorithm because it unsafe. There are 2 methods can help.
- Generate your ssh key in `ed25519` algorithm. For example, `ssh-keygen -t ed25519`.
- Add `HostkeyAlgorithms +ssh-rsa\n    PubkeyAcceptedAlgorithms +ssh-rsa\n    PubkeyAcceptedKeyTypes +ssh-rsa` to `~/.ssh/config`. For example, `Hostname user@your-ip.com\n    HostkeyAlgorithms +ssh-rsa\n    PubkeyAcceptedAlgorithms +ssh-rsa\n    PubkeyAcceptedKeyTypes +ssh-rsa\n`

## License

MIT
