# Local Site Publisher (with Cloudflare Tunnel)

A lightweight, zero-configuration tool to instantly serve your local static websites and share them globally with a secure, temporary public URL.

This project uses a simple Python HTTP server and Cloudflare Quick Tunnels to expose your local files to the internet without messing with router ports or DNS settings.

## Features
- 🚀 **Zero Config:** Just run the script in your website's folder.
- 🔒 **Secure:** Generates an HTTPS link via Cloudflare.
- 🧹 **Clean Exit:** Automatically kills the background Python server when you close the tunnel.

## Prerequisites

Before running the script, ensure you have the following installed on your system:

1. **Python 3** (pre-installed on most Linux/macOS systems).
2. **cloudflared**: The Cloudflare Tunnel daemon.
   - *Arch Linux:* `yay -S cloudflared-bin`
   - *macOS:* `brew install cloudflare/cloudflare/cloudflared`
   - *Ubuntu/Debian:* Download the `.deb` from the [official Cloudflare docs](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/downloads/).

## How to Use

1. Drop `serve.py` and `start_server.sh` into the root directory of your static website (where your `index.html` is located).
2. Open your terminal in that directory.
3. Make the bash script executable (you only need to do this once):
   ```bash
   chmod +x start_server.sh
   ```
4. Run the script:
   ```bash
   ./start_server.sh
   ```

## What Happens Next?
1. The script will start a local web server on port `8000`.
2. It will launch `cloudflared` to create a secure tunnel.
3. Look at your terminal output for a line containing a `.trycloudflare.com` URL. 
4. **Copy and share that link!** Anyone in the world can now view your site.

## How to Stop
To stop hosting your site, simply press `CTRL + C` in the terminal. The script is designed to safely catch the exit signal and shut down both the Cloudflare tunnel and the local Python server.