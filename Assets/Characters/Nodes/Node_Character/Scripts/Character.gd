extends Node
class_name Character

@export var character_name: String

@export_enum(
	"PLAYER",
	"NPC",
	"EMEMY",
	"ANIMAL"
) var character_type

@export var character_skin: Texture2D

## The points the character will patrol between
@export var character_patrol_events: NPCEvents

## 
@export var character_schedule_events: NPCEvents
