---
title: Dark Reader
---

## Metadata
|   |   |
|---|---|
| Repo | https://github.com/firefox-extensions-declarative/darkreader-declarative |
| Extension ID | `addon@darkreader.org` |

## Types

### `Theme`
Custom theme.

:::note
You have to specify every value here.
:::

#### `brightness`
How bright to make things (0 to 100+).  
Type: `number`  
Default: `100`  

#### `contrast`
How much contrast to add (0 - 100+).  
Type: `number`  
Default: `100`  

#### `grayscale`
How much grayscale to add (0 - 100).  
Type: `number`  
Default: `0`  

#### `sepia`
How much sepia to add (0 - 100).  
Type: `number`  
Default: `0`  

#### `useFont`
Whether to use the custom font.  
Type: `boolean`  
Default: `false`  

#### `fontFamily`
The font family to use.  
Type: `string`  

#### `textStroke`
Makes text look bolder (0 - 1 pixels).  
Type: `number`  
Default: `0`  

#### `engine`
The theme engine to use.  
Type: `"cssFilter" | "svgFilter" | "staticTheme" | "dynamicTheme"`  
Default: `"dynamicTheme"`  

#### `stylesheet`
Additional CSS to add.  
Type: `string`  
Default: `""`  

#### `darkSchemeBackgroundColor`
Background color to use for dark mode.  
Type: `string`  
Default: `"#181a1b"`  

#### `darkSchemeTextColor`
Text color to use for dark mode.  
Type: `string`  
Default: `"#e8e6e3"`  

#### `lightSchemeBackgroundColor`
Background color to use for light mode.  
Type: `string`  
Default: `"#dcdad7"`  

#### `lightSchemeTextColor`
Text color to use for light mode.  
Type: `string`  
Default: `"#181a1b"`  

#### `scrollbarColor`
Scrollbar color.  
Type: `string`  
Default: `"auto"`  

#### `selectionColor`
Selection color.  
Type: `string`  
Default: `"auto"`  

#### `styleSystemControls`
Specifies if it has to style system controls.  
Type: `boolean`  
Default: `true`  

#### `darkColorScheme`
<!-- TODO: find what this is actually for -->
I don't know. Just put default, that works.  
Type: `string`  

#### `lightColorScheme`
<!-- TODO: find what this is actually for -->
I don't know. Just put default, that works.  
Type: `string`  

### `CustomSiteConfig`
Custom site configuration.  

#### `builtIn`
Should be false.  
Type: `boolean`  

#### `url`
URLs to enable the theme for.  
Type: `Array<string>`  

#### `theme`
The theme to apply to the site.  
Type: `Theme`  

### `ThemePreset`
Theme preset.

#### `id`
ID of the preset.  
Type: `string`  

#### `name`
Name of the preset.  
Type: `string`  

#### `theme`
The theme to apply to the site.  
Type: `Theme`  

#### `urls`
URLs to enable the theme preset for.  
Type: `Array<string>`  

## Options

### `automation.enabled`
Whether to enable Automation.  
Type: `boolean`  
Default: `false`  

### `automation.behavior`
The automation behavior. `OnOff` means automation will enable/disable Dark Reader, while `Scheme` means it will change between Light Reader and Dark Reader.  
Type: `"OnOff" | "Scheme"`  
Default: `OnOff`  

### `automation.mode`
The automation mode.  
Type: `"" | "time" | "system" | "location"`  
Default: `""`  

### `changeBrowserTheme`
Whether to change the browser theme to sync with the Dark Reader theme.  
Type: `boolean`  
Default: `false`  

### `customThemes`
Custom site configurations.  
Type: `Array<CustomSiteConfig>`  
Default: `[]`  

### `detectDarkTheme`
Whether to auto-detect dark themes and disable Dark Reader.  
Type: `boolean`  
Default: `true`  

### `disabledFor`
List of custom sites to disable Dark Reader on.  
Type: `Array<string>`  
Default: `[]`  

### `enableContextMenus`
Whether to enable the Dark Reader context menus.  
Type: `boolean`  
Default: `true`  

### `enableForPDF`
Whether to enable Dark Reader on PDF files.  
Type: `boolean`  
Default: `true`  

### `enableForProtectedPages`
Whether to enable Dark Reader on browser-protected pages.  
Type: `boolean`  
Default: `false`  

### `enabled`
Whether to enable Dark Reader.  
Type: `boolean`  
Default: `true`  

### `enabledByDefault`
Whether to enable Dark Reader by default for sites.  
Type: `boolean`  
Default: `true`  

### `enabledFor`
Sites to enable Dark Reader on.  
Type: `Array<string>`  
Default: `[]`  

### `fetchNews`
Whether to fetch news for Dark Reader.  
Type: `boolean`  
Default: `true`  

### `location.latitude`
The latitude (for automation).  
Type: `number | null`  
Default: `null`  

### `location.longitude`
The longitude (for automation).  
Type: `number | null`  
Default: `null`  

### `presets`
Theme presets.  
Type: `Array<ThemePreset>`  
Default: `[]`  

### `previewNewDesign`
Preview the new Dark Reader design.  
Type: `boolean`  
Default: `false`  

### `previewNewestDesign`
Preview the newest Dark Reader design.  
Type: `boolean`  
Default: `false`  

### `syncSettings`
Whether to sync Dark Reader settings.  
Type: `boolean`  
Default: `false`  

### `syncSitesFixes`
Whether to sync Dark Reader site fixes.  
Type: `boolean`  
Default: `false`  

### `theme`
The Dark Reader theme to use.  
Type: `Theme`  
Default: `DEFAULT_THEME`  

### `time.activation`
Activation time for automation.  
Type: `string`  
Default: `"18:00"`  

### `time.deactivation`
Deactivation time for automation.  
Type: `string`  
Default: `"9:00"`  
