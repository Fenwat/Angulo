extends Node
class_name CharacterInput

@onready var movement_manager = $"../MovementManager"

var input_direction: Vector2
var last_non_zero_input: Vector2 = Vector2(0, 0.1)

func _physics_process(_delta):
	#direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	_get_input_direction()
	_check_sprint()

func _get_input_direction():
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_direction != Vector2.ZERO:
		last_non_zero_input = input_direction

func _check_sprint():
	if Input.is_action_pressed("sprint"):
		movement_manager.handle_sprint()
	
	if Input.is_action_just_released("sprint"):
		movement_manager.sprint_released()
