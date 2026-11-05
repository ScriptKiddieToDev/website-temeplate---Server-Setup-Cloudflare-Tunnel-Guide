import http.server
import socketserver
import sys

PORT = 8000

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        # Serve la directory corrente (dove si trova il file)
        super().__init__(*args, directory=".", **kwargs)

try:
    with socketserver.TCPServer(("", PORT), Handler) as httpd:
        print(f"[*] Server locale avviato con successo.")
        print(f"[*] In ascolto su http://localhost:{PORT}")
        httpd.serve_forever()
except KeyboardInterrupt:
    print("\n[*] Server locale interrotto.")
    sys.exit(0)
except Exception as e:
    print(f"[!] Errore nell'avvio del server: {e}")
    sys.exit(1)
