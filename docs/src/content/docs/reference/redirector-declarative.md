---
title: Redirector
---

## Metadata
|   |   |
|---|---|
| Repo | https://github.com/firefox-extensions-declarative/Redirector-declarative |
| Extension ID | `redirector@einaregilsson.com` |

## Building
Run `python3 build.py`. The XPI is located at `build/redirector-firefox.xpi`.

Thanks to [@chuangzhu](https://github.com/chuangzhu) for making patch this uses.

## Types

### `Redirect`
A single Redirector rule.

#### `description`
Human-readable rule name.  
Type: `string`

#### `exampleUrl`
Example URL that matches rule.  
Type: `string`

#### `exampleResult`
Example result after redirect.  
Type: `string`

#### `error`
Rule validation error, if any. Usually `null`.  
Type: `string | null`

#### `includePattern`
Pattern to match URLs against.  
Type: `string`

#### `excludePattern`
Pattern to exclude from matching.  
Type: `string`

#### `patternDesc`
Human-readable explanation of pattern.  
Type: `string`

#### `redirectUrl`
Target URL to redirect to.  
Type: `string`

#### `patternType`
Pattern type.  
Type: `"W" | "R" | "C" | string`

- `W`: wildcard
- `R`: regular expression
- `C`: compatibility pattern

#### `processMatches`
How Redirector processes matched groups.  
Type: `"noProcessing" | string`

#### `disabled`
Whether rule is disabled.  
Type: `boolean`

#### `grouped`
Whether rule is grouped in Redirector UI.  
Type: `boolean`

#### `appliesTo`
Request types this rule applies to.  
Type: `Array<string>`

Common values include `"main_frame"`, `"sub_frame"`, `"stylesheet"`, `"script"`, `"image"`, `"xmlhttprequest"`, and `"other"`.

## Options

### `redirects`
List of Redirector rules.  
Type: `Array<Redirect>`  
Default: `[]`
