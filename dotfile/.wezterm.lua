local wezterm = require("wezterm")

local launch_menu = {}
local default_prog = {}
local set_environment_variables = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	default_prog = { "pwsh.exe", "-NoLogo" }
elseif wezterm.target_triple == "aarch64-apple-darwin" then
	default_prog = { "/bin/zsh", "-l" }
end

-- based on https://github.com/ivaquero/oxidizer.sh/blob/master/defaults/wezterm.lua

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- Title
wezterm.on("format-tab-title", function(tab) --, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane
	local title = basename(pane.foreground_process_name)

	return {
		{
			Text = " " .. title .. " ",
		},
	}
end)

local config = {
	check_for_updates = false,
	-- pane_focus_follows_mouse = true,

	-- Window
	-- Font and color scheme
	font_size = 16,
	font = wezterm.font_with_fallback({
		-- "CodeNewRoman Nerd Font Mono",
		"ComicShannsMono Nerd Font Mono",
		"Kaiti SC",
	}),
	-- Colorschemes:
	-- https://wezfurlong.org/wezterm/colorschemes/b/index.html
	color_scheme = "Catppuccin Frappe",
	-- Initial GUI size
	initial_cols = 96,
	initial_rows = 30,
	native_macos_fullscreen_mode = true,
	adjust_window_size_when_changing_font_size = true,
	-- window_close_confirmation = 'NeverPrompt',
	-- window_decorations = 'RESIZE',
	-- window_background_opacity = 0.9,
	window_padding = {
		left = 10,
		right = 5,
		top = 0,
		bottom = 0,
	},
	window_background_image_hsb = {
		brightness = 0.8,
		hue = 1.0,
		saturation = 1.0,
	},
	-- Keys
	disable_default_key_bindings = true,
	leader = {
		key = "z",
		mods = "CTRL",
	},
	-- Allow using ^ with single key press.
	use_dead_keys = false,
	keys = {
		-- New/close pane
		{
			key = "c",
			mods = "LEADER",
			action = wezterm.action({
				SpawnTab = "CurrentPaneDomain",
			}),
		},
		{
			key = "x",
			mods = "LEADER",
			action = wezterm.action({
				CloseCurrentPane = {
					confirm = true,
				},
			}),
		},
		{
			key = "X",
			mods = "LEADER",
			action = wezterm.action({
				CloseCurrentTab = {
					confirm = true,
				},
			}),
		}, -- Pane navigation
		{
			key = "h",
			mods = "LEADER",
			action = wezterm.action({
				ActivatePaneDirection = "Left",
			}),
		},
		{
			key = "j",
			mods = "LEADER",
			action = wezterm.action({
				ActivatePaneDirection = "Down",
			}),
		},
		{
			key = "k",
			mods = "LEADER",
			action = wezterm.action({
				ActivatePaneDirection = "Up",
			}),
		},
		{
			key = "l",
			mods = "LEADER",
			action = wezterm.action({
				ActivatePaneDirection = "Right",
			}),
		}, -- Tab navigation
		{
			key = "z",
			mods = "LEADER",
			action = "TogglePaneZoomState",
		},
		{
			key = "1",
			mods = "LEADER",
			action = wezterm.action({
				ActivateTab = 0,
			}),
		},
		{
			key = "2",
			mods = "LEADER",
			action = wezterm.action({
				ActivateTab = 1,
			}),
		},
		{
			key = "3",
			mods = "LEADER",
			action = wezterm.action({
				ActivateTab = 2,
			}),
		},
		{
			key = "4",
			mods = "LEADER",
			action = wezterm.action({
				ActivateTab = 3,
			}),
		},
		{
			key = "5",
			mods = "LEADER",
			action = wezterm.action({
				ActivateTab = 4,
			}),
		},
		{
			key = "6",
			mods = "LEADER",
			action = wezterm.action({
				ActivateTab = 5,
			}),
		},
		{
			key = "7",
			mods = "LEADER",
			action = wezterm.action({
				ActivateTab = 6,
			}),
		},
		{
			key = "8",
			mods = "LEADER",
			action = wezterm.action({
				ActivateTab = 7,
			}),
		},
		{
			key = "9",
			mods = "LEADER",
			action = wezterm.action({
				ActivateTab = 8,
			}),
		},
		{
			key = "n",
			mods = "LEADER",
			action = "ShowTabNavigator",
		},
		{
			key = "b",
			mods = "LEADER",
			action = "ActivateLastTab",
		},
		{
			key = "LeftArrow",
			mods = "CMD",
			action = wezterm.action({
				ActivateTabRelative = -1,
			}),
		},
		{
			key = "RightArrow",
			mods = "CMD",
			action = wezterm.action({
				ActivateTabRelative = 1,
			}),
		}, -- Resize
		{
			key = "H",
			mods = "LEADER",
			action = wezterm.action({
				AdjustPaneSize = { "Left", 5 },
			}),
		},
		{
			key = "J",
			mods = "LEADER",
			action = wezterm.action({
				AdjustPaneSize = { "Down", 5 },
			}),
		},
		{
			key = "K",
			mods = "LEADER",
			action = wezterm.action({
				AdjustPaneSize = { "Up", 5 },
			}),
		},
		{
			key = "L",
			mods = "LEADER",
			action = wezterm.action({
				AdjustPaneSize = { "Right", 5 },
			}),
		}, -- Split
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "\\",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({
				domain = "CurrentPaneDomain",
			}),
		}, -- H12
		{
			key = "_",
			mods = "LEADER",
			action = wezterm.action.Multiple({
				wezterm.action.SplitPane({
					direction = "Down",
					size = {
						Percent = 40,
					},
				}),
				wezterm.action.SplitPane({
					direction = "Left",
					size = {
						Percent = 40,
					},
				}),
			}),
		}, -- V12
		{
			key = "|",
			mods = "LEADER",
			action = wezterm.action.Multiple({
				wezterm.action.SplitPane({
					direction = "Right",
					size = {
						Percent = 40,
					},
				}),
				wezterm.action.SplitPane({
					direction = "Down",
					size = {
						Percent = 60,
					},
				}),
			}),
		}, -- Square
		{
			key = ";",
			mods = "LEADER",
			action = wezterm.action.Multiple({
				wezterm.action.SplitPane({
					direction = "Right",
					size = {
						Percent = 40,
					},
				}),
				wezterm.action.SplitPane({
					direction = "Down",
					size = {
						Percent = 50,
					},
				}),
				wezterm.action.SplitPane({
					direction = "Down",
					size = {
						Percent = 40,
					},
					top_level = true,
				}),
			}),
		}, -- Copy/paste buffer
		{
			key = "y",
			mods = "LEADER",
			action = "ActivateCopyMode",
		},
		{
			key = "v",
			mods = "LEADER",
			action = "QuickSelect",
		},
		{
			key = "c",
			mods = "CMD",
			action = wezterm.action.CopyTo("Clipboard"),
		},
		{
			key = "v",
			mods = "CMD",
			action = wezterm.action.PasteFrom("Clipboard"),
		},
	},
	-- Tab bar appearance
	hide_tab_bar_if_only_one_tab = true,
	enable_tab_bar = true,
	show_tab_index_in_tab_bar = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	inactive_pane_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.0,
	},
	mouse_bindings = {
		-- Paste on right-click
		{
			event = {
				Down = {
					streak = 1,
					button = "Right",
				},
			},
			mods = "NONE",
			action = wezterm.action({
				PasteFrom = "Clipboard",
			}),
		}, -- Change the default click behavior so that it only selects
		-- text and doesn't open hyperlinks
		{
			event = {
				Up = {
					streak = 1,
					button = "Left",
				},
			},
			mods = "NONE",
			action = wezterm.action({
				CompleteSelection = "PrimarySelection",
			}),
		}, -- CTRL-Click open hyperlinks
		{
			event = {
				Up = {
					streak = 1,
					button = "Left",
				},
			},
			mods = "CTRL",
			action = "OpenLinkAtMouseCursor",
		},
	},
	default_prog = default_prog,
	set_environment_variables = set_environment_variables,
	launch_menu = launch_menu,
	ssh_domains = {
		{
			name = "mcdr",
			remote_address = "192.168.1.5",
			ssh_option = {
				identityfile = "~/.ssh/z-admin",
			},
			multiplexing = "WezTerm",
		},
	},
}

return config
