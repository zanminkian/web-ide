const cp = require('child_process');
const httpProxy = require('http-proxy')
const http = require('http')

const proxy = new httpProxy.createProxyServer({
  target: {
    host: 'localhost',
    port: 9090
  }
});

let codeServerAlive = false
const server = http.createServer(function (req, res) {
  if(!codeServerAlive) {
    cp.spawnSync('/usr/lib/code-server/lib/node', '')
    codeServerAlive = true
  }
  proxy.web(req, res);
});

let timestamp = 0
server.on('upgrade', function (req, socket, head) {
  socket.on('data', ()=>{
    timestamp = Date.now()
  })
  proxy.ws(req, socket, head);
});

server.listen(Number(process.env.PORT || '8080'));


setInterval(() => {
  if(Date.now() - timestamp > 5 * 60 * 1000) {
    killCodeServer()
  }
}, 60_000)

function getCodeServerPid() {
  const COMMAND = '/usr/lib/code-server/lib/node /usr/lib/code-server'

  const out = cp.spawnSync('ps', ['-aux']).stdout.toString().split('\n')
  const result = out.filter(i => i.includes(COMMAND + ' ') || i.endsWith(COMMAND))[0]?.match(/^root\s+([0-9]+)/)
  const pid = Number(result?.[1])
  return pid
}

function killCodeServer() {
  const pid = getCodeServerPid()
  if (pid) {
    console.log(`Going to kill ${pid}`);
    cp.spawnSync('kill', ['-2', String(pid)])
    codeServerAlive = false
  }
}
