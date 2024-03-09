extends Node
class_name CharacterMovement

@export var walk_speed: int
@export var jog_speed: int
@export var sprint_speed: int

@onready var character = $".."
@onready var character_input = $"../CharacterInput"

@onready var move_speed: int = walk_speed
var velocity: Vector2 = Vector2.ZERO

var position_locked: bool = false
var is_sprinting: bool = false

enum character_direction{
	NORTH,
	EAST,
	SOUTH,
	WEST
}

var current_character_direction = character_direction.SOUTH

# Debug variables
var debug_character_direction_enabled: bool = false

#----------------------------------------------------------------------------------------
#----------------------------------Physics-Process---------------------------------------
#----------------------------------------------------------------------------------------

func _physics_process(_delta):
	_handle_movement()
	_determine_character_direction()

func _handle_movement():
	if position_locked:
		character.velocity = Vector2.ZERO
	else:
		character.velocity = character_input.input_direction * move_speed
	
	character.move_and_slide()

func _determine_character_direction():
	if character_input.last_non_zero_input.y < 0 and abs(character_input.last_non_zero_input.x) < abs(character_input.last_non_zero_input.y):
		current_character_direction = character_direction.NORTH
	elif character_input.last_non_zero_input.x > 0 and abs(character_input.last_non_zero_input.x) > abs(character_input.last_non_zero_input.y):
		current_character_direction = character_direction.EAST
	elif character_input.last_non_zero_input.y > 0 and abs(character_input.last_non_zero_input.x) < abs(character_input.last_non_zero_input.y):
		current_character_direction = character_direction.SOUTH
	elif character_input.last_non_zero_input.x < 0 and abs(character_input.last_non_zero_input.x) > abs(character_input.last_non_zero_input.y):
		current_character_direction = character_direction.WEST
	
	debug_character_direction()

#----------------------------------------------------------------------------------------
#-----------------------------------Input-Triggered--------------------------------------
#----------------------------------------------------------------------------------------

#--------------------------------------Sprint--------------------------------------------

func sprint_pressed():
	is_sprinting = true
	move_speed = sprint_speed

func sprint_released():
	is_sprinting = false
	move_speed = walk_speed

#----------------------------------Attack-Movement---------------------------------------

func move_character(attack_state: CharacterState):
	match current_character_direction:
		character_direction.NORTH:
			character.position.y -= attack_state.attack_data.attack_step_size_north
		character_direction.EAST:
			character.position.x += attack_state.attack_data.attack_step_size_east
		character_direction.SOUTH:
			character.position.y += attack_state.attack_data.attack_step_size_south
		character_direction.WEST:
			character.position.x -= attack_state.attack_data.attack_step_size_west

#----------------------------------------------------------------------------------------
#---------------------------------------Debug--------------------------------------------
#----------------------------------------------------------------------------------------

func debug_character_direction():
	if debug_character_direction_enabled:
		match current_character_direction:
			character_direction.NORTH:
				print(character.character_name, " facing north")
			character_direction.EAST:
				print(character.character_name, " facing east")
			character_direction.SOUTH:
				print(character.character_name, " facing south")
			character_direction.WEST:
				print(character.character_name, " facing west")
