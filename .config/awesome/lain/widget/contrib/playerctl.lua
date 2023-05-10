-- infos from mpris clients such as spotify and VLC
--[[ based on https://github.com/acrisci/playerctl
local mpris, mpris_timer = awful.widget.watch(
	{ awful.util.shell, "-c", "playerctl status && playerctl metadata" },
	2,
	function(widget, stdout)
		local escape_f = require("awful.util").escape
		local mpris_now = {
			state = "N/A",
			artist = "N/A",
			title = "N/A",
			art_url = "N/A",
			album = "N/A",
			album_artist = "N/A",
		}

		mpris_now.state = string.match(stdout, "Playing") or string.match(stdout, "Paused") or "N/A"

		for k, v in string.gmatch(stdout, "'[^:]+:([^']+)':[%s]<%[?'([^']+)'%]?>") do
			if k == "artUrl" then
				mpris_now.art_url = v
			elseif k == "artist" then
				mpris_now.artist = escape_f(v)
			elseif k == "title" then
				mpris_now.title = escape_f(v)
			elseif k == "album" then
				mpris_now.album = escape_f(v)
			elseif k == "albumArtist" then
				mpris_now.album_artist = escape_f(v)
			end
		end

		-- customize here
		widget:set_text(mpris_now.artist .. " - " .. mpris_now.title)
	end
)
]]

local helpers = require("lain.helpers")
local shell = require("awful.util").shell
local escape_f = require("awful.util").escape
local focused = require("awful.screen").focused
local naughty = require("naughty")
local wibox = require("wibox")
local string = string

local function factory(args)
	args = args or {}

	local player = { widget = args.widget or wibox.widget.textbox() }
	local timeout = args.timeout or 2
	--local cover_pattern = args.cover_pattern or "*\\.(jpg|jpeg|png|gif)$"
	local cover_size = args.cover_size or 100
	local default_art = args.default_art
	local notify = args.notify or "on"
	local followtag = args.followtag or false
	local settings = args.settings or function() end

	local cmd = string.format("playerctl status && playerctl metadata")

	player_notification_preset = { title = "Now playing", timeout = 6 }

	helpers.set_map("current player track", nil)

	function player.update()
		helpers.async({ shell, "-c", cmd }, function(stdout)
			player_now = {
				state = "N/A",
				artist = "N/A",
				title = "N/A",
				art_url = "N/A",
				album = "N/A",
				album_artist = "N/A",
				length = "N/A",
			}

			player_now.state = string.match(stdout, "Playing") or string.match(stdout, "Paused") or "N/A"

			for k, v in string.gmatch(stdout, "'[^:]+:([^']+)':[%s]<%[?'([^']+)'%]?>") do
				if k == "artUrl" then
					player_now.art_url = v
				elseif k == "artist" then
					player_now.artist = escape_f(v)
				elseif k == "title" then
					player_now.title = escape_f(v)
				elseif k == "album" then
					player_now.album = escape_f(v)
				elseif k == "albumArtist" then
					player_now.album_artist = escape_f(v)
				elseif k == "length" then
					player_now.length = v
				end
			end

			player_notification_preset.text =
				string.format("%s (%s)\n%s", player_now.albumArtist, player_now.album, player_now.title)
			widget = player.widget
			settings()

			if player_now.state == "Playing" then
				if notify == "on" and player_now.title ~= helpers.get_map("current player track") then
					helpers.set_map("current player track", player_now.title)

					if followtag then
						player_notification_preset.screen = focused()
					end

					local common = {
						preset = player_notification_preset,
						icon = default_art,
						icon_size = cover_size,
						replaces_id = player.id,
					}

					if not string.match(player_now.art_url, "http.*://") then -- local file instead of http stream
						--[[local path = string.format("%s/%s", music_dir, string.match(player_now.file, ".*/"))
						local cover = string.format(
							"find '%s' -maxdepth 1 -type f | egrep -i -m1 '%s'",
							path:gsub("'", "'\\''"),
							cover_pattern
						)
						helpers.async({ shell, "-c", cover }, function(current_icon)
							common.icon = current_icon:gsub("\n", "")
							if #common.icon == 0 then
								common.icon = nil
							end
							player.id = naughty.notify(common).id
						end) ]]
						player.id = naughty.notify(common).id
					else
						player.id = naughty.notify(common).id
					end
				end
			elseif player_now.state ~= "Paused" then
				helpers.set_map("current player track", nil)
			end
		end)
	end

	player.timer = helpers.newtimer("player", timeout, player.update, true, true)

	return player
end

return factory
