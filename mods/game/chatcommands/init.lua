-- Chatcommands for SSG

core.register_chatcommand("load", {
	params = "<map>",
	privs = {match_manager = true},
	description = "Load a map",
	func = function(_, param)
		if not param or param == "" then
			return false, "-!- You must specify a map name!"
		end

		if match_state == "pre_match" or match_state == "post_match" or match_state == "in_progress" then
			return false, "-!- Match is already in progress!"
		end

		map_data = place_map(param)

		return true, "-!- Map loaded!"
	end
})

core.register_chatcommand("start", {
	params = "",
	privs = {match_manager = true},
	description = "Start the match",
	func = function()
		start_match()
		return true, "-!- Match started!"
	end
})

core.register_chatcommand("reset", {
	params = "",
	privs = {match_manager = true},
	description = "Terminate the match",
	func = function()
		if match_state ~= "pre_match" and match_state ~= "post_match" and match_state ~= "not_started" then
			core.chat_send_all(core.colorize("red", "Match terminated."))
			end_match()

			return true
		end

		return false, "Match cannot be terminated at the moment."
	end
})
