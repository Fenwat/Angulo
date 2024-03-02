extends Node
class_name CharacterSignalEmitter

@onready var character = $".."

func _physics_process(_delta):
	signal_player_position()

func signal_player_position():
	var character_position = character.position
	PlayerSignalBus.emit_signal("player_position_updated", character_position)
