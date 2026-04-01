#!/usr/bin/env zsh
set -e

# `dbus-x11` is required for lxqt. Otherwise it will crash.
apt install --no-install-recommends -y lxqt-core dbus-x11 qterminal
# `desktop-base` provides default themes and artwork for Debian desktop environments.
# It's optional for LXQt but recommended for better visual appearance.
apt install --no-install-recommends -y desktop-base
# `fonts-noto-cjk` and `fonts-noto-color-emoji` is for displaying Chinese.
apt install --no-install-recommends -y fonts-noto-cjk fonts-noto-color-emoji
apt install --no-install-recommends -y tigervnc-standalone-server tigervnc-tools
git clone https://github.com/novnc/noVNC.git /usr/lib/noVNC --depth=1
git clone https://github.com/novnc/websockify.git /usr/lib/noVNC/utils/websockify --depth=1
ln -s /usr/lib/noVNC/utils/novnc_proxy /usr/bin/novnc_proxy

echo '#!/usr/bin/env bash
set -e

show_help() {
    echo "Usage: start-desktop [OPTIONS]"
    echo ""
    echo "Start the LXQt desktop environment with VNC and noVNC."
    echo ""
    echo "Options:"
    echo "  --password[=PASSWORD]  Set VNC password for authentication."
    echo "                         If PASSWORD is not provided, you will be prompted."
    echo "  -h, --help             Show this help message and exit."
    echo ""
    echo "Examples:"
    echo "  start-desktop                    # Start without password (no authentication)"
    echo "  start-desktop --password=mypass  # Start with password"
    echo "  start-desktop --password         # Start with empty password"
    exit 0
}

password=""
password_provided=false
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
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
    vncserver -rfbauth ~/.vnc/passwd :1
fi
nohup novnc_proxy --vnc localhost:5901 > /dev/null 2>&1 &
sleep 1
' > /usr/bin/start-desktop
chmod +x /usr/bin/start-desktop

echo '#!/usr/bin/env bash
set -e

show_help() {
    echo "Usage: stop-desktop [OPTIONS]"
    echo ""
    echo "Stop the LXQt desktop environment (VNC server and noVNC proxy)."
    echo ""
    echo "Options:"
    echo "  -h, --help  Show this help message and exit."
    exit 0
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
    esac
    shift
done

vncserver -kill :1
kill -15 $(ps -ef | grep "novnc_proxy --vnc localhost:5901" | grep -v grep | awk "{print \$2}")
' > /usr/bin/stop-desktop
chmod +x /usr/bin/stop-desktop

apt install --no-install-recommends -y chromium
echo '#!/usr/bin/env bash
/usr/bin/chromium --no-sandbox "$@"
' > /usr/local/bin/chromium
chmod +x /usr/local/bin/chromium
