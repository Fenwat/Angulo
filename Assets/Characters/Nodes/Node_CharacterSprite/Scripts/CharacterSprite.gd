extends Node
class_name CharacterSprite

@export var sprite_2d: Sprite2D

@export var character_sprites: Array[CharacterSpriteElement]

@onready var character = $".."
#@onready var sprite_2d = $"../Sprite2D"

#func _ready():
	#sprite_2d.texture = character_sprites[0].character_sprite_sheet
