extends Node
class_name MovementComponent

@export var input_component: InputComponent

@export var walk_speed: int
@export var jog_speed: int
@export var sprint_speed: int

@onready var entity = $".."

@onready var move_speed: int = walk_speed

var velocity: Vector2 = Vector2.ZERO
var direction_vector: Vector2 = Vector2.ZERO
var last_non_zero_direction_vector: Vector2 = Vector2.ZERO
var call_function: String = ""

var position_locked: bool = false
var is_sprinting: bool = false

enum entity_direction{
	NORTH,
	EAST,
	SOUTH,
	WEST
}

enum entity_type {
	PLAYER,
	NPC,
	ENEMY,
	ANIMAL
}

var current_entity_direction = entity_direction.SOUTH
var current_entity_direction_locked: bool = false
# Debug variables
var debug_entity_direction_enabled: bool = false

#----------------------------------------------------------------------------------------
#----------------------------------Physics-Process---------------------------------------
#----------------------------------------------------------------------------------------

func _physics_process(_delta):
	_assign_input_vectors()
	_handle_movement()
	_determine_entity_direction()

#------------------------------------Input-Source----------------------------------------

func _assign_input_vectors():
	direction_vector = input_component.input_direction
	last_non_zero_direction_vector = input_component.last_non_zero_input

#--------------------------------------Movement------------------------------------------

func _handle_movement():
	if position_locked:
		entity.velocity = Vector2.ZERO
	else:
		entity.velocity = direction_vector * move_speed
	
	entity.move_and_slide()

#---------------------------------Character_Direction------------------------------------

func _determine_entity_direction():
	if current_entity_direction_locked == true: return
	
	if last_non_zero_direction_vector.y < 0 and abs(last_non_zero_direction_vector.x) < abs(last_non_zero_direction_vector.y):
		current_entity_direction = entity_direction.NORTH
	elif last_non_zero_direction_vector.x > 0 and abs(last_non_zero_direction_vector.x) > abs(last_non_zero_direction_vector.y):
		current_entity_direction = entity_direction.EAST
	elif last_non_zero_direction_vector.y > 0 and abs(last_non_zero_direction_vector.x) < abs(last_non_zero_direction_vector.y):
		current_entity_direction = entity_direction.SOUTH
	elif last_non_zero_direction_vector.x < 0 and abs(last_non_zero_direction_vector.x) > abs(last_non_zero_direction_vector.y):
		current_entity_direction = entity_direction.WEST
	
	debug_entity_direction()

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

func move_entity(attack_state: EntityState):
	match current_entity_direction:
		entity_direction.NORTH:
			entity.position.y -= attack_state.attack_data.attack_step_size_north
		entity_direction.EAST:
			entity.position.x += attack_state.attack_data.attack_step_size_east
		entity_direction.SOUTH:
			entity.position.y += attack_state.attack_data.attack_step_size_south
		entity_direction.WEST:
			entity.position.x -= attack_state.attack_data.attack_step_size_west

#----------------------------------------------------------------------------------------
#---------------------------------------Debug--------------------------------------------
#----------------------------------------------------------------------------------------

func debug_entity_direction():
	if debug_entity_direction_enabled:
		match current_entity_direction:
			entity_direction.NORTH:
				print(entity.entity_name, " facing north")
			entity_direction.EAST:
				print(entity.entity_name, " facing east")
			entity_direction.SOUTH:
				print(entity.entity_name, " facing south")
			entity_direction.WEST:
				print(entity.entity_name, " facing west")
