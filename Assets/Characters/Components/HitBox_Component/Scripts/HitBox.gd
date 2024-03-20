extends Area2D
class_name HitBox

@export var state_machine: CharacterStateMachine
@export var movement: CharacterMovement

@export var state_machine_component: StateMachineComponent
@export var movement_component: MovementComponent

@onready var hitbox_shape = $CollisionShape2D

var current_state: CharacterState

func _ready():
	set_default_hitbox()

func _process(_delta):
	_set_current_state()

func _set_current_state():
	if state_machine == null: return
	
	current_state = state_machine.current_character_state

func set_default_hitbox():
	hitbox_shape.disabled = true
	hitbox_shape.shape.size = Vector2(3, 3)
	hitbox_shape.position = Vector2(0, -8)

func set_hitbox():
	if movement == null: return
	
	hitbox_shape.disabled = false
	if movement.current_character_direction == 0:
		_handle_north_hitbox()
	elif movement.current_character_direction == 1:
		_handle_east_hitbox()
	elif movement.current_character_direction == 2:
		_handle_south_hitbox()
	elif movement.current_character_direction == 3:
		_handle_west_hitbox()

func _handle_north_hitbox():
	hitbox_shape.shape.size = current_state.attack_data.north_hitbox_size
	hitbox_shape.position = current_state.attack_data.north_hitbox_position

func _handle_south_hitbox():
	hitbox_shape.shape.size = current_state.attack_data.south_hitbox_size
	hitbox_shape.position = current_state.attack_data.south_hitbox_position

func _handle_east_hitbox():
	hitbox_shape.shape.size = current_state.attack_data.east_hitbox_size
	hitbox_shape.position = current_state.attack_data.east_hitbox_position

func _handle_west_hitbox():
	hitbox_shape.shape.size = current_state.attack_data.west_hitbox_size
	hitbox_shape.position = current_state.attack_data.west_hitbox_position

func _on_area_entered(area):
	print(area)
