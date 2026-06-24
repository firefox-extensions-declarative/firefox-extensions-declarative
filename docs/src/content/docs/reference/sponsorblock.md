---
title: SponsorBlock
---

## Metadata
|   |   |
|---|---|
| Repo | https://github.com/firefox-extensions-declarative/SponsorBlock-declarative |
| Extension ID | `sponsorBlocker@ajay.app` |

## Building
Run `npm install` and then `npm run build:firefox`.

To create the XPI, run:
```bash
npx web-ext build -s dist -a web-ext-artifacts
```

The XPI will be located in `web-ext-artifacts/`.

## Types

### `Keybind`
Keyboard shortcut.  

#### `key`
Key name.  
Type: `string | null`  

#### `code`
Keyboard code.  
Type: `string | null`  

#### `ctrl`
Whether Ctrl is required.  
Type: `boolean | null`  

#### `alt`
Whether Alt is required.  
Type: `boolean | null`  

#### `shift`
Whether Shift is required.  
Type: `boolean | null`  

### `CategorySelection`
Skip behavior for one category.  

#### `name`
Category name.  
Type: `string`  

Common values include `"sponsor"`, `"selfpromo"`, `"interaction"`, `"intro"`, `"outro"`, `"preview"`, `"music_offtopic"`, `"poi_highlight"`, `"filler"`, `"exclusive_access"`, and `"chapter"`.

#### `option`
Skip behavior.  
Type: `-2 | -1 | 0 | 1 | 2`  

- `-2`: fallback to default
- `-1`: disabled
- `0`: show overlay
- `1`: manual skip
- `2`: auto skip

### `PreviewBarOption`
Preview bar style.  

#### `color`
Bar color.  
Type: `string`  

#### `opacity`
Bar opacity.  
Type: `string`  

## Options

This section lists supported policy preferences. It intentionally omits account IDs, counters, payment state, and other runtime/stateful values even if they exist in sync storage.

### `permissions`
Per-category submission permissions.  
Type: `Record<string, { canSubmit: boolean }>`  
Default: `{}`  

### `defaultCategory`
Default category when creating segments.  
Type: `string`  
Default: `"chooseACategory"`  

### `segmentListDefaultTab`
Default popup tab.  
Type: `0 | 1`  
Default: `0`  

- `0`: segments
- `1`: chapters

### `renderSegmentsAsChapters`
Render segments as chapters.  
Type: `boolean`  
Default: `false`  

### `forceChannelCheck`
Force channel check before submission-related actions.  
Type: `boolean`  
Default: `false`  

### `showTimeWithSkips`
Show saved time with skips.  
Type: `boolean`  
Default: `true`  

### `disableSkipping`
Disable all skipping.  
Type: `boolean`  
Default: `false`  

### `muteSegments`
Mute muted categories instead of skipping them.  
Type: `boolean`  
Default: `true`  

### `fullVideoSegments`
Enable support for full-video segments.  
Type: `boolean`  
Default: `true`  

### `fullVideoLabelsOnThumbnails`
Show full-video labels on thumbnails.  
Type: `boolean`  
Default: `true`  

### `manualSkipOnFullVideo`
Require manual skip for full-video segments.  
Type: `boolean`  
Default: `false`  

### `trackViewCount`
Track total views for stats.  
Type: `boolean`  
Default: `true`  

### `trackViewCountInPrivate`
Track views in private windows.  
Type: `boolean`  
Default: `true`  

### `trackDownvotes`
Track downvotes locally.  
Type: `boolean`  
Default: `true`  

### `trackDownvotesInPrivate`
Track downvotes in private windows.  
Type: `boolean`  
Default: `false`  

### `dontShowNotice`
Disable skip notices.  
Type: `boolean`  
Default: `false`  

### `showUpcomingNotice`
Show upcoming skip notice.  
Type: `boolean`  
Default: `false`  

### `noticeVisibilityMode`
Skip notice display mode.  
Type: `0 | 1 | 2 | 3 | 4`  
Default: `3`  

- `0`: full size
- `1`: mini for auto-skip
- `2`: mini for all
- `3`: faded for auto-skip
- `4`: faded for all

### `hideVideoPlayerControls`
Hide SponsorBlock player controls.  
Type: `boolean`  
Default: `false`  

### `hideInfoButtonPlayerControls`
Hide info button in player controls.  
Type: `boolean`  
Default: `false`  

### `hideDeleteButtonPlayerControls`
Hide delete button in player controls.  
Type: `boolean`  
Default: `false`  

### `hideUploadButtonPlayerControls`
Hide upload button in player controls.  
Type: `boolean`  
Default: `false`  

### `hideSkipButtonPlayerControls`
Hide skip button in player controls.  
Type: `boolean`  
Default: `false`  

### `hideDiscordLink`
Hide Discord link.  
Type: `boolean`  
Default: `false`  

### `invidiousInstances`
List of Invidious instances.  
Type: `Array<string>`  
Default: `[]`  

### `supportInvidious`
Enable Invidious support.  
Type: `boolean`  
Default: `false`  

### `serverAddress`
SponsorBlock API server.  
Type: `string`  
Default: value from repo `config.json`  

### `minDuration`
Minimum segment duration to skip.  
Type: `number`  
Default: `0`  

### `skipNoticeDuration`
How long skip notices stay visible.  
Type: `number`  
Default: `4`  

### `audioNotificationOnSkip`
Play audio notification on skip.  
Type: `boolean`  
Default: `false`  

### `checkForUnlistedVideos`
Check for unlisted videos during submission flows.  
Type: `boolean`  
Default: `false`  

### `testingServer`
Use testing server.  
Type: `boolean`  
Default: `false`  

### `allowExperiments`
Enable experimental features.  
Type: `boolean`  
Default: `true`  

### `showDonationLink`
Show donation link.  
Type: `boolean`  
Default: `true`  

### `showUpsells`
Show upsell UI.  
Type: `boolean`  
Default: `true`  

### `showNewFeaturePopups`
Show new feature popups.  
Type: `boolean`  
Default: `true`  

### `autoHideInfoButton`
Auto-hide info button.  
Type: `boolean`  
Default: `true`  

### `autoSkipOnMusicVideos`
Auto-skip on music videos.  
Type: `boolean`  
Default: `false`  

### `skipNonMusicOnlyOnYoutubeMusic`
Only skip non-music segments on YouTube Music.  
Type: `boolean`  
Default: `false`  

### `colorPalette`
Named colors used by UI.  
Type: `{ red: string; white: string; locked: string }`  
Default: `{ red: "#780303", white: "#ffffff", locked: "#ffc83d" }`  

### `scrollToEditTimeUpdate`
Enable updated scroll-to-edit-time behavior.  
Type: `boolean`  
Default: `false`  

### `darkMode`
Use dark mode in extension UI.  
Type: `boolean`  
Default: `true`  

### `showCategoryGuidelines`
Show category guidelines.  
Type: `boolean`  
Default: `true`  

### `showCategoryWithoutPermission`
Show categories without permission.  
Type: `boolean`  
Default: `false`  

### `showSegmentNameInChapterBar`
Show segment names in chapter bar.  
Type: `boolean`  
Default: `true`  

### `showAutogeneratedChapters`
Show autogenerated YouTube chapters.  
Type: `boolean`  
Default: `true`  

### `useVirtualTime`
Use virtual time for segment timing.  
Type: `boolean`  
Default: `true`  

### `showSegmentFailedToFetchWarning`
Show warning when segments fail to fetch.  
Type: `boolean`  
Default: `true`  

### `allowScrollingToEdit`
Allow scrolling to edit timestamps.  
Type: `boolean`  
Default: `true`  

### `showZoomToFillError2`
Show zoom-to-fill warning.  
Type: `boolean`  
Default: `true`  

### `cleanPopup`
Use cleaner popup layout.  
Type: `boolean`  
Default: `false`  

### `hideSegmentCreationInPopup`
Hide popup segment creation UI.  
Type: `boolean`  
Default: `false`  

### `prideTheme`
Enable pride theme.  
Type: `boolean`  
Default: `false`  

### `skipKeybind`
Skip keybind.  
Type: `Keybind`  
Default: `{ key: "Enter" }`  

### `skipToHighlightKeybind`
Skip to highlight keybind.  
Type: `Keybind`  
Default: `{ key: "Enter", ctrl: true }`  

### `startSponsorKeybind`
Start segment keybind.  
Type: `Keybind`  
Default: `{ key: ";" }`  

### `submitKeybind`
Submit keybind.  
Type: `Keybind`  
Default: `{ key: "'" }`  

### `actuallySubmitKeybind`
Confirm submit keybind.  
Type: `Keybind`  
Default: `{ key: "'", ctrl: true }`  

### `previewKeybind`
Preview keybind.  
Type: `Keybind`  
Default: `{ key: ";", ctrl: true }`  

### `nextChapterKeybind`
Next chapter keybind.  
Type: `Keybind`  
Default: `{ key: "ArrowRight", ctrl: true }`  

### `previousChapterKeybind`
Previous chapter keybind.  
Type: `Keybind`  
Default: `{ key: "ArrowLeft", ctrl: true }`  

### `closeSkipNoticeKeybind`
Close skip notice keybind.  
Type: `Keybind`  
Default: `{ key: "Backspace" }`  

### `downvoteKeybind`
Downvote keybind.  
Type: `Keybind`  
Default: `{ key: "h", shift: true }`  

### `upvoteKeybind`
Upvote keybind.  
Type: `Keybind`  
Default: `{ key: "g", shift: true }`  

### `categorySelections`
Skip behavior per category.  
Type: `Array<CategorySelection>`  
Default: sponsor auto-skip, poi highlight manual skip, exclusive access show overlay, chapter show overlay  

### `barTypes`
Preview bar colors and opacity for each category.  
Type: `Record<string, PreviewBarOption>`  
Default: see [`src/config.ts`](https://github.com/firefox-extensions-declarative/SponsorBlock-declarative/blob/declarative/src/config.ts)  
