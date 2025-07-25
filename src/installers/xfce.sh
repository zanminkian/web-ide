#!/usr/bin/env zsh
set -e

# `dbus-x11`` is required for xfce4. Otherwise it will crash.
# `fonts-noto-cjk` and `fonts-noto-color-emoji` is for displaying Chinese.
apt install --no-install-recommends -y xfce4 dbus-x11 xfce4-terminal tigervnc-standalone-server fonts-noto-cjk fonts-noto-color-emoji
git clone https://github.com/novnc/noVNC.git /usr/lib/noVNC --depth=1
git clone https://github.com/novnc/websockify.git /usr/lib/noVNC/utils/websockify --depth=1
ln -s /usr/lib/noVNC/utils/novnc_proxy /usr/bin/novnc_proxy

echo '#!/usr/bin/env sh
set -e
vncserver -SecurityTypes None :1
nohup novnc_proxy --vnc localhost:5901 > /dev/null 2>&1 &
' > /usr/bin/start-desktop
chmod +x /usr/bin/start-desktop

echo "#!/usr/bin/env sh
set -e
vncserver -kill :1
kill -15 \$(ps -ef | grep 'novnc_proxy --vnc localhost:5901' | grep -v grep | awk '{print \$2}')
" > /usr/bin/stop-desktop
chmod +x /usr/bin/stop-desktop
