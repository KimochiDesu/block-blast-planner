# Block Blast Planner

Tap in your 8×8 Block Blast board and your three pieces. The planner shows the best order and spot for each piece, which lines it clears, and how the board looks after your turn.

It's a single static page (`index.html`) with no build step.

## Run on Windows / any PC

```
python -m http.server 8080
```

Then open http://localhost:8080. You can also just open `index.html` in a browser.

## Run on an Ubuntu server

```
git clone <this repo> block-blast-planner
cd block-blast-planner
chmod +x deploy/install-ubuntu.sh
./deploy/install-ubuntu.sh
```

This installs nginx and serves the page on port 8080. Use `PORT=80 ./deploy/install-ubuntu.sh` for a different port. To update later:

```
git pull && ./deploy/install-ubuntu.sh
```
