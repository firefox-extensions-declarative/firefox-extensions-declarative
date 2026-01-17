---
title: Violentmonkey
---

## Metadata
|   |   |
|---|---|
| Repo | https://github.com/firefox-extensions-declarative/violentmonkey-declarative |
| Extension ID | `{aecec67f-0d10-4fa7-b7c7-609a2db280cf}` |

## Building
Run the following:
```bash
yarn install
yarn run build
cd dist/
zip -r ../violentmonkey.xpi .
cd ..
```
The XPI will be located at `violentmonkey.xpi`.

## Options

### `options`
Violentmonkey options. See [the source code](https://github.com/violentmonkey/violentmonkey/blob/140b8c6/src/common/options-defaults.js) for a full list of options.  
Type: `Record<string, unknown>`  
Default: `{}`  

### `scripts`
The userscripts to add to Violentmonkey.  
Type: `Array<string>`  
Default: `[]`  
