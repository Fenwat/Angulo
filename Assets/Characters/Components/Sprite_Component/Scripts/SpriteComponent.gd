extends Node
class_name SpriteComponent

@export var sprite_2d: Sprite2D

@export var entity_sprites: Array[SpriteElement]

@onready var entity = $".."
#@onready var sprite_2d = $"../Sprite2D"

#func _ready():
	#sprite_2d.texture = character_sprites[0].character_sprite_sheet
