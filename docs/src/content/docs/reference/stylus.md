---
title: Stylus
---

## Metadata
|   |   |
|---|---|
| Repo | https://github.com/firefox-extensions-declarative/stylus-declarative |
| Extension ID | `{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}` |

## Building
Run `pnpm install` and then `npm run build-firefox`.  
To create the XPI, run the following:
```bash
cd dist-firefox/
zip -r ../stylus.xpi .
cd ..
```
The XPI will be located at `stylus.xpi`.

## Types

### `Style`

#### `code`
The userstyle's code.  
Type: `string`  

#### `variables`
The userstyle variables.  
Type: `Record<string, string>`  

## Options

### `prefs`
Stylus preferences. See [the source code](https://github.com/firefox-extensions-declarative/stylus-declarative/blob/ff615c0/src/js/prefs.js#L31-L181) for a full list of preferences.  
Type: `Record<string, unknown>`  
Default: `{}`  

### `styles`
Array of styles.  
Type: `Array<Style>`  
Default: `[]`  
