extends Node2D

@onready var level_bounds = $BoundingArea/BoundingBox

func _ready():
	signal_bounding_box()

func signal_bounding_box():
	var bounding_box = Vector2(level_bounds.shape.size)
	LevelSignalBus.emit_signal("level_bounding_box", bounding_box)
