extends Node2D

@onready var sprite_2d = $"../../Sprite2D"

var player_skin_map = preload("res://Assets/Characters/Player/Shaders/Skins/player_skin_map.png")
var player_skin_index = preload("res://Assets/Characters/Player/Shaders/Skins/player_skin_index.png")
var source_rect_pixels = []
var dest_rect_pixels = []

func set_new_skin(new_source_rect, new_dest_rect):
	process_source_rect(new_source_rect)
	process_dest_rect(new_dest_rect)
	change_skin_texture()
	save_skin_texture()

func process_source_rect(source_rect):
	for x in range(source_rect[0], source_rect[0] + source_rect[2]):
		for y in range(source_rect[1], source_rect[1] + source_rect[3]):
			var source_dimensions = Vector2(x, y)
			source_rect_pixels.append(source_dimensions)

func process_dest_rect(dest_rect):
	for x in range(dest_rect[0], dest_rect[0] + dest_rect[2]):
		for y in range(dest_rect[1], dest_rect[1] + dest_rect[3]):
			var dest_dimensions = Vector2(x, y)
			dest_rect_pixels.append(dest_dimensions)

func change_skin_texture():
	for i in range(len(source_rect_pixels)):
		var source_pixel = source_rect_pixels[i]
		var dest_pixel = dest_rect_pixels[i]
		var index_color = player_skin_index.get_pixel(source_pixel.x, source_pixel.y)
		player_skin_map.set_pixel(dest_pixel.x, dest_pixel.y, index_color)

func save_skin_texture():
	player_skin_map.save_png("res://Assets/Characters/Player/Shaders/Skins/player_skin_map.png")
	var player_skin_map_texture = ImageTexture.create_from_image(player_skin_map)
	sprite_2d.material.set_shader_parameter("SkinMap", player_skin_map_texture)
