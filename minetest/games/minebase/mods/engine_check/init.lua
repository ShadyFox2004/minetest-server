-- Check for engine features required by Minebase
-- This provides clear error behaviour when Minebase is newer than the installed 
-- engine and avoids obscure, hard to debug runtime errors.
-- This section should be updated before release and older checks can be dropped
-- when newer ones are introduced.
if not minetest.is_creative_enabled or not minetest.has_feature({
		direct_velocity_on_players = true,
		use_texture_alpha_string_modes = true,
	}) then
	error("\nThis version of Minebase is incompatible with your engine" ..
		" version (which is too old).") 
end
