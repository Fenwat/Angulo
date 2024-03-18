extends Node
class_name Entity

@export var entity_name: String

@export_enum(
	"PLAYER",
	"NPC",
	"EMEMY",
	"ANIMAL",
	"OBJECT"
) var entity_type

