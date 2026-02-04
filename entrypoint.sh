#!/usr/bin/env bash
set -e

PORT="${PORT:-8080}"

# 修改 phish_server.listen_url => 0.0.0.0:$PORT
jq --arg p "$PORT" '.phish_server.listen_url = ("0.0.0.0:" + $p)' /opt/gophish/config.json > /opt/gophish/config.json.tmp
mv /opt/gophish/config.json.tmp /opt/gophish/config.json

echo "[*] Starting gophish with phish_server on 0.0.0.0:${PORT}"
cd /opt/gophish
./gophish
