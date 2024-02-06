extends Node2D

@onready var player = $"../.."

func _physics_process(_delta):
	signal_player_position()

func signal_player_position():
	var player_position = player.position
	PlayerSignalBus.emit_signal("player_position_updated", player_position)
