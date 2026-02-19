-- Chatcommands for SSG

core.register_chatcommand("start", {
	params = "<map>",
	privs = {match_manager = true},
	description = "Start a match on <map>",
	func = function(_, param)
		if not param or param == "" then
			return false, "-!- You must specify a map name!"
		end

		if match_state == "pre_match" or match_state == "post_match" or match_state == "in_progress" then
			return false, "-!- Match is already in progress!"
		end
		
		local sucess = start_match(param)

		if map_data == "nope :(" then
			return false, "-!- Map not found!"
		end

		return true, "-!- Match started!"
	end
})

core.register_chatcommand("stop", {
	params = "",
	privs = {match_manager = true},
	description = "Terminate the match",
	func = function()
		if match_state ~= "post_match" and match_state ~= "not_started" then
			core.chat_send_all(core.colorize("red", "Match terminated."))
			end_match()

			return true
		end

		return false, "Match cannot be terminated at the moment."
	end
})

core.register_chatcommand("list_maps", {
	params = "",
	privs = {match_manager = true},
	description = "List all maps",
	func = function()
		local maps = core.get_dir_list(core.get_modpath("maps") .. "/maps", true)
		local map_list = "Available maps:\n"
		for _, map in pairs(maps) do
			map_list = map_list .. map .. "\n"
		end
		return true, map_list .. "\nUse /start <map> to start a match."
	end
})