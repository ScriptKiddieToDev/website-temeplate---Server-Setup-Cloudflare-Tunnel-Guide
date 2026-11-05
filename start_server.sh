#!/bin/bash

PORT=8000

echo "=================================================="
echo "      APEX 90 - SERVER & CLOUDFLARE TUNNEL"
echo "=================================================="

# Verifica se python3 è installato
if ! command -v python3 &> /dev/null; then
    echo "[!] python3 non trovato. Assicurati che sia installato."
    exit 1
fi

# Verifica se cloudflared è installato
if ! command -v cloudflared &> /dev/null; then
    echo "[!] 'cloudflared' non è installato sul tuo sistema."
    echo "[*] Visto che usi Arch Linux, puoi installarlo tramite AUR eseguendo:"
    echo "    yay -S cloudflared-bin"
    echo "[*] Dopo l'installazione, riavvia questo script."
    exit 1
fi

# Avvia il server Python in background
echo "[*] Avvio del server web locale sulla porta $PORT..."
python3 serve.py &
PYTHON_PID=$!

# Attendi un secondo per dare tempo al server di avviarsi
sleep 1

# Funzione per chiudere il server locale quando si esce dallo script
cleanup() {
    echo -e "\n[*] Chiusura del server locale (PID: $PYTHON_PID)..."
    kill $PYTHON_PID 2>/dev/null
    echo "[*] Disconnesso."
    exit 0
}

# Cattura i segnali di uscita (CTRL+C) e lancia la funzione di cleanup
trap cleanup SIGINT SIGTERM

echo "[*] Richiesta del tunnel a Cloudflare in corso..."
echo "[*] Attendi qualche secondo per il link pubblico (cerca la riga con .trycloudflare.com)"
echo "--------------------------------------------------"

# Avvia il tunnel Cloudflare temporaneo (Quick Tunnel)
cloudflared tunnel --url http://localhost:$PORT

# Se cloudflared si chiude per qualche motivo, esegui il cleanup
cleanup
