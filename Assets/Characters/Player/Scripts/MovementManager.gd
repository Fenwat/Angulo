extends Node2D


@onready var player = $"../.."
@onready var input_manager = $"../InputManager"

const walk_speed: int = 35
const sprint_speed: int = 80

var move_speed: int = walk_speed
var is_sprinting: bool = false
var velocity: Vector2 = Vector2.ZERO
var input_direction: Vector2 = Vector2.ZERO

func _physics_process(_delta):
	input_direction = input_manager.direction
	
	handle_movement()

func handle_movement():
	player.velocity = input_direction * move_speed
	
	player.move_and_slide()

func handle_sprint():
	is_sprinting = true
	move_speed = sprint_speed

func sprint_released():
	is_sprinting = false
	move_speed = walk_speed
	
