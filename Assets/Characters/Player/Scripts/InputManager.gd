extends Node2D

@onready var movement_manager = $"../MovementManager"

var direction: Vector2

func _physics_process(_delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	_check_sprint()

func _check_sprint():
	if Input.is_action_pressed("sprint"):
		movement_manager.handle_sprint()
	
	if Input.is_action_just_released("sprint"):
		movement_manager.sprint_released()

