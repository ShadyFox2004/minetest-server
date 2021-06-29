-- base_players/init.lua

local model, texture
if minetest.settings:get("extended_model") == "true" then
	model = "base_players_model_extended.b3d" 
	texture = "base_players_sam_extended.png"
else
	model = "base_players_model.b3d"
	texture = "base_players_sam.png"
end

-- Default player appearance
players.register_model(model, {
	animation_speed = 30,
	textures = {texture},
	animations = {
		-- Standard animations.
		stand     = {x = 0,   y = 79},
		lay       = {x = 162, y = 166},
		walk      = {x = 168, y = 187},
		mine      = {x = 189, y = 198},
		walk_mine = {x = 200, y = 219},
		sit       = {x = 81,  y = 160},
	},
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	stepheight = 0.6,
	eye_height = 1.47,
})

-- Update appearance when the player joins
minetest.register_on_joinplayer(function(player)
	players.player_attached[player:get_player_name()] = false
	players.set_model(player, model, {texture})
	player:set_local_animation(
		{x = 0,   y = 79},
		{x = 168, y = 187},
		{x = 189, y = 198},
		{x = 200, y = 219},
		30
	)
end)
