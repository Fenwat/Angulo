extends Node
class_name CharacterMovement

@export var character_input: CharacterInput

@export var walk_speed: int
@export var jog_speed: int
@export var sprint_speed: int

@onready var character = $".."

@onready var move_speed: int = walk_speed

var velocity: Vector2 = Vector2.ZERO
var direction_vector: Vector2 = Vector2.ZERO
var last_non_zero_direction_vector: Vector2 = Vector2.ZERO
var call_function: String = ""

var position_locked: bool = false
var is_sprinting: bool = false

enum character_direction{
	NORTH,
	EAST,
	SOUTH,
	WEST
}

enum character_type {
	PLAYER,
	NPC,
	ENEMY,
	ANIMAL
}

var current_character_direction = character_direction.SOUTH

# Debug variables
var debug_character_direction_enabled: bool = false

#----------------------------------------------------------------------------------------
#----------------------------------Physics-Process---------------------------------------
#----------------------------------------------------------------------------------------

func _physics_process(_delta):
	_assign_input_vectors()
	_handle_movement()
	_determine_character_direction()

#------------------------------------Input-Source----------------------------------------

func _assign_input_vectors():
	direction_vector = character_input.input_direction
	last_non_zero_direction_vector = character_input.last_non_zero_input

#--------------------------------------Movement------------------------------------------

func _handle_movement():
	if position_locked:
		character.velocity = Vector2.ZERO
	else:
		character.velocity = direction_vector * move_speed
	
	character.move_and_slide()

#---------------------------------Character_Direction------------------------------------

func _determine_character_direction():
	if last_non_zero_direction_vector.y < 0 and abs(last_non_zero_direction_vector.x) < abs(last_non_zero_direction_vector.y):
		current_character_direction = character_direction.NORTH
	elif last_non_zero_direction_vector.x > 0 and abs(last_non_zero_direction_vector.x) > abs(last_non_zero_direction_vector.y):
		current_character_direction = character_direction.EAST
	elif last_non_zero_direction_vector.y > 0 and abs(last_non_zero_direction_vector.x) < abs(last_non_zero_direction_vector.y):
		current_character_direction = character_direction.SOUTH
	elif last_non_zero_direction_vector.x < 0 and abs(last_non_zero_direction_vector.x) > abs(last_non_zero_direction_vector.y):
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
