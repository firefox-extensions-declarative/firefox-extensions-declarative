---
title: userchrome-toggle-extended-2
---

## Metadata
|   |   |
|---|---|
| Repo | https://github.com/firefox-extensions-declarative/userchrome-toggle-extended-2-declarative |
| Extension ID | `userchrome-toggle-extended@n2ezr.ru` |

## Options

### `allowMultiple`
Whether to allow multiple styles to be active together.
Type: `boolean`
Default: `false`

### `closePopup`
Whether to close the popup after clicking a toggle.
Type: `boolean`
Default: `false`

### `useLastWindowToggles`
Whether to use the toggles from the previous window when making a new window.
Type: `boolean`
Default: `false`

### `keepToggles`
Whether to apply toggles from previous session on startup.
Type: `boolean`
Default: `false`

### `toggles`
A list of 6 toggles.  
Type: `list`  
Default:
```js
[
	{
		name: "Style 1",
		enabled: true,
		prefix: "\u180E",
		default_state: true
	},
	{
		name: "Style 2",
		enabled: false,
		prefix: "\u200B",
		default_state: false
	},
	{
		name: "Style 3",
		enabled: false,
		prefix: "\u200C",
		default_state: false
	},
	{
		name: "Style 4",
		enabled: false,
		prefix: "\u200D",
		default_state: false
	},
	{
		name: "Style 5",
		enabled: false,
		prefix: "\u200E",
		default_state: false
	},
	{
		name: "Style 6",
		enabled: false,
		prefix: "\u200F",
		default_state: false
	}
]
```
