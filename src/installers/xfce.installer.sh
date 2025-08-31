#!/usr/bin/env zsh
set -e

# `dbus-x11`` is required for xfce4. Otherwise it will crash.
# `fonts-noto-cjk` and `fonts-noto-color-emoji` is for displaying Chinese.
apt install --no-install-recommends -y xfce4 dbus-x11 xfce4-terminal
apt install --no-install-recommends -y fonts-noto-cjk fonts-noto-color-emoji
apt install --no-install-recommends -y tigervnc-standalone-server tigervnc-tools
git clone https://github.com/novnc/noVNC.git /usr/lib/noVNC --depth=1
git clone https://github.com/novnc/websockify.git /usr/lib/noVNC/utils/websockify --depth=1
ln -s /usr/lib/noVNC/utils/novnc_proxy /usr/bin/novnc_proxy

echo '#!/usr/bin/env bash
set -e

password=""
password_provided=false
while [[ $# -gt 0 ]]; do
    case "$1" in
        --password)
            password_provided=true
            if [[ $# -gt 1 && $2 != --* ]]; then
                password="$2"
                shift
            else
                password=""
            fi
            ;;
        --password=*)
            password_provided=true
            password="${1#*=}"
            ;;
    esac
    shift
done

mkdir -p ~/.vnc
mkdir -p ~/.config/tigervnc
if [ "$password_provided" = false ]; then
    vncserver -SecurityTypes None :1
else
    echo -e "$password\n$password" | vncpasswd -f > ~/.vnc/passwd
    chmod 600 ~/.vnc/passwd
    vncserver :1
fi
nohup novnc_proxy --vnc localhost:5901 > /dev/null 2>&1 &
sleep 1
' > /usr/bin/start-desktop
chmod +x /usr/bin/start-desktop

echo "#!/usr/bin/env bash
set -e
vncserver -kill :1
kill -15 \$(ps -ef | grep 'novnc_proxy --vnc localhost:5901' | grep -v grep | awk '{print \$2}')
" > /usr/bin/stop-desktop
chmod +x /usr/bin/stop-desktop

apt install --no-install-recommends -y chromium
echo '#!/usr/bin/env bash
/usr/bin/chromium --no-sandbox "$@"
' > /usr/local/bin/chromium
chmod +x /usr/local/bin/chromium
