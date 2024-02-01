extends Node2D

@onready var player = $"../.."
@onready var input_manager = $"../InputManager"

var velocity: Vector2 = Vector2.ZERO
var input_direction: Vector2 = Vector2.ZERO

@export var move_speed: int = 35
@export var is_sprinting: bool = false

func _physics_process(delta):
	input_direction = input_manager.direction
	
	handle_movement(delta)

func handle_movement(_delta):
	player.velocity = input_direction * move_speed
	
	player.move_and_slide()

func handle_sprint():
	is_sprinting = true
	move_speed = 80

func sprint_released():
	is_sprinting = false
	move_speed = 35
	
