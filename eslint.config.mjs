import antfu from "@antfu/eslint-config"
import format from "eslint-plugin-format"

export default antfu(
	{
		stylistic: {
			indent: "tab",
			quotes: "double",
			overrides: {
				"style/brace-style": ["error", "1tbs", { allowSingleLine: true }],
			},
		},

		typescript: true,
		markdown: true,
		astro: true,
	},
	{
		files: ["**/*.md"],
		rules: {
			"style/no-trailing-spaces": "off",
		},
	},
	{
		files: ["**/*.css"],
		languageOptions: {
			parser: format.parserPlain,
		},
		plugins: {
			format,
		},
		rules: {
			"format/dprint": ["error", {
				plugins: [
					{
						plugin: "node_modules/dprint-plugin-malva/plugin.wasm",
						options: {},
					},
				],
				useTabs: true,
				indentWidth: 4,
			}],
		},
	},
	{
		files: ["**/*.astro"],
		plugins: {
			format,
		},
		rules: {
			"format/dprint": ["error", {
				plugins: [
					{
						plugin: "node_modules/dprint-plugin-malva/plugin.wasm",
						options: {},
					},
					{
						plugin: "node_modules/dprint-plugin-markup/plugin.wasm",
						options: {
							scriptIndent: true,
							styleIndent: true,
							preferAttrsSingleLine: true,
							closingTagLineBreakForEmpty: "never",
							whitespaceSensitivity: "ignore",
							astroAttrShorthand: true,
						},
					},
				],
				useTabs: true,
				indentWidth: 4,
			}],
		},
	},
)
