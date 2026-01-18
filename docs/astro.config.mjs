import starlight from "@astrojs/starlight"
import catppuccin from "@catppuccin/starlight"
// @ts-check
import { defineConfig } from "astro/config"

// https://astro.build/config
export default defineConfig({
	site: "https://firefox-extensions-declarative.github.io",
	integrations: [
		starlight({
			plugins: [catppuccin({
				dark: { flavor: "mocha", accent: "green" },
				light: { flavor: "latte", accent: "green" },
			})],
			title: "Firefox Extensions Declarative",
			social: [{ icon: "github", label: "GitHub", href: "https://github.com/firefox-extensions-declarative" }],
			sidebar: [
				{
					label: "Getting Started",
					autogenerate: { directory: "getting-started" },
				},
				{
					label: "Reference",
					autogenerate: { directory: "reference" },
				},
				{
					label: "Contributing",
					autogenerate: { directory: "contributing" },
				},
			],
		}),
	],
})
