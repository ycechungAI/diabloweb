#!/usr/bin/env bash
set -euo pipefail

NODE_VER="${1:-24}"

echo "==> Targeting Node v${NODE_VER}"
echo "${NODE_VER}" > .nvmrc

# Update package.json engines.node
node -e "
const fs=require('fs');
const p='package.json';
const j=JSON.parse(fs.readFileSync(p,'utf8'));
j.engines = j.engines || {};
j.engines.node = '>=' + process.argv[1];
fs.writeFileSync(p, JSON.stringify(j,null,2)+'\n');
" "$NODE_VER"
echo "==> Updated package.json engines.node to >=${NODE_VER}"

# Regenerate lockfile
echo "==> Regenerating package-lock.json (npm $(npm -v), node $(node -v))"
rm -f package-lock.json
npm install --package-lock-only

# Validate
node -e "JSON.parse(require('fs').readFileSync('package-lock.json','utf8')); console.log('==> package-lock.json OK')"

echo "==> Done. Commit .nvmrc, package.json, and package-lock.json."
echo "==> Note: if using Webpack 4 on newer Node, builds may need NODE_OPTIONS=--openssl-legacy-provider."
