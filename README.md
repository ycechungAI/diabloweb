## Diablo 1 for web browsers!

This project is based on https://github.com/diasurgical/devilution.

Source code to build the WebAssembly modules is here: https://github.com/d07RiV/devilution

I've modified the code to remove all dependencies and exposed the minimal required interface with JS, allowing the game to be compiled into WebAssembly.

Event handling (especially in the menus) had to be modified significantly to fit the JS model.

To play the full game, you must use your own DIABDAT.MPQ that you can obtain
with the original copy of the game from [GoG](url=https://www.gog.com/game/diablo).

## Development

### Updating Node.js / dependencies

Use `update.sh` to update the Node.js target, regenerate `package-lock.json`, and keep the project config in sync:

```bash
./update.sh 24   # or: ./update.sh 26
```

This will:
- write the version to `.nvmrc`
- set `package.json` `engines.node` to `>=<version>`
- regenerate `package-lock.json` (`npm install --package-lock-only`)

After running it, commit `.nvmrc`, `package.json`, and `package-lock.json`, then verify:

```bash
npm ci
npm run build
```

If the build fails on newer Node versions with a Webpack 4/OpenSSL error, try:

```bash
NODE_OPTIONS=--openssl-legacy-provider npm run build
```

Use the same Node major version in CI (the workflows read `.nvmrc`).
