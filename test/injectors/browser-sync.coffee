# browser-sync サーバー
host = window.location.hostname
port = 3000;

# スクリプトの挿入
document.write """
  <script src="http://#{host}:#{port}/socket.io/socket.io.js"></script>
  <script>___socket___ = io.connect("http://#{host}:#{port}")</script>
  <script src="http://#{host}:#{port+1}/client/browser-sync-client.min.js"></script>
"""
