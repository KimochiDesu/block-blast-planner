# Block Blast Planner

Tap in your 8×8 Block Blast board and your three pieces. The planner shows the best order and spot for each piece, which lines it clears, and how the board looks after your turn.

It's a single static page (`public/index.html`) with no build step.

## Run on Windows / any PC

```
cd public
python -m http.server 8080
```

Then open http://localhost:8080. You can also just open `public/index.html` in a browser.

## Run on the Ubuntu server (Docker)

From the project folder on the server:

```
docker compose up -d
```

The planner is served by nginx on port 8092: http://192.168.1.100:8092. Change the port in `compose.yaml` if needed.

Page edits show up right away because `public/` is mounted into the container. Refresh the browser after replacing `public/index.html`; no restart is needed.
