extends Node
class_name Character

@export var character_name: String

@export_enum(
	"PLAYER",
	"NPC",
	"EMEMY",
	"ANIMAL"
) var character_type
