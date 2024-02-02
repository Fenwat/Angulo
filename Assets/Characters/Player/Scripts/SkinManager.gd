extends Node2D

@onready var sprite_2d = $"../../Sprite2D"

var player_skin_map = preload("res://Assets/Characters/Player/Shaders/Skins/player_skin_map.png")
var player_skin_index = preload("res://Assets/Characters/Player/Shaders/Skins/player_skin_index.png")
var index_color = Vector4()
var source_rect = Vector4()
var dest_rect = Vector4()
var source_rect_pixels = []
var dest_rect_pixels = []

func _ready():
	#set_new_skin()
	pass

func set_new_skin(type, new_source_rect):
	source_rect = new_source_rect
	dest_rect = get_destination_rect(type)
	process_source_rect()
	process_dest_rect()
	for i in range(len(source_rect_pixels)):
		var source_pixel = source_rect_pixels[i]
		var dest_pixel = dest_rect_pixels[i]
		index_color = player_skin_index.get_pixel(source_pixel.x, source_pixel.y)
		player_skin_map.set_pixel(dest_pixel.x, dest_pixel.y, index_color)
	player_skin_map.save_png("res://Assets/Characters/Player/Shaders/Skins/player_skin_map.png")
	var player_skin_map_texture = ImageTexture.create_from_image(player_skin_map)
	sprite_2d.material.set_shader_parameter("SkinMap", player_skin_map_texture)

func process_source_rect():
	var source_x_start = source_rect[0]
	var source_y_start = source_rect[1]
	var source_width = source_rect[2]
	var source_height = source_rect[3]
	var source_dimensions = Vector2()
	for x in range(source_x_start, source_x_start + source_width):
		for y in range(source_y_start, source_y_start + source_height):
			source_dimensions = Vector2(x, y)
			source_rect_pixels.append(source_dimensions)
	return source_rect_pixels

func process_dest_rect():
	var dest_x_start = dest_rect[0]
	var dest_y_start = dest_rect[1]
	var dest_width = dest_rect[2]
	var dest_height = dest_rect[3]
	var dest_dimensions = Vector2()
	for x in range(dest_x_start, dest_x_start + dest_width):
		for y in range(dest_y_start, dest_y_start + dest_height):
			dest_dimensions = Vector2(x, y)
			dest_rect_pixels.append(dest_dimensions)
	return source_rect_pixels

func get_destination_rect(type):
	match type:
		Enums.EquipmentType.CAPE:
			return Vector4(1, 1, 5, 11)
		Enums.EquipmentType.HELMET:
			return Vector4(7, 1, 15, 4)
		Enums.EquipmentType.CHESTPLATE:
			return Vector4(7, 5, 15, 7)
		Enums.EquipmentType.GAUNTLETS:
			return Vector4(23, 1, 6, 3)
		Enums.EquipmentType.LEGGINGS:
			return Vector4(23, 5, 6, 7)
		Enums.EquipmentType.STRAIGHTSWORD:
			return Vector4(1, 13, 10, 3)
		Enums.EquipmentType.SPEAR:
			return Vector4(1, 17, 16, 1)
		_:
			return Vector4(0, 0, 0, 0)
