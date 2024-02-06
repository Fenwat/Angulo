extends Node2D

@export var move_speed: float = 15.0

@onready var random_navigator = $RandomNavigator
@onready var state_machine = $"../StateMachine"

var move_direction: Vector2 = Vector2.ZERO

var direction: Vector2
var last_non_zero_input: Vector2 = Vector2(0, 0.1)

func _physics_process(_delta):	
	direction = move_direction.normalized()
	if direction != Vector2.ZERO:
		last_non_zero_input = direction

func select_navigator():
	pass
