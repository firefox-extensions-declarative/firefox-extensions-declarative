---
title: Surfingkeys
---

## Metadata
|   |   |
|---|---|
| Repo | https://github.com/firefox-extensions-declarative/surfingkeys-declarative |
| Extension ID | `surfingkeys@brookhong.github.io` |

## Building
Run `npm install` and then `browser=firefox npm run build:prod`. The XPI is located at `dist/production/firefox/sk.zip`.

## Options

### `showAdvanced`
Enabled "Advanced Mode".

### `snippets`
The Surfingkeys JavaScript configuration.
Example:
```js
api.unmap("A") // LLM Chat
```
