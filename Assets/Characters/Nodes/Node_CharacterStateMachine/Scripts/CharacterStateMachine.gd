extends Node

## Array of all character states. Order does not matter.
@export var states: Array[CharacterState]

@onready var character = $".."
@onready var character_input = $"../CharacterInput"
@onready var movement_manager = $"../ScriptManager/MovementManager"
@onready var character_animator = $"../CharacterAnimator"

var character_state_locked: bool = false

# CharacterState storage arrays 
var idle_states: Array[CharacterState]
var idle_insert_states: Array[CharacterState]
var movement_states: Array[CharacterState]
var attack_states: Array[CharacterState]

var current_character_state: CharacterState

# Toggle debugs
var debug_current_character_state_active: bool = false
var debug_character_states_active: bool = false

# Needs to be identical to the enum in the CharacterState class. Order matters.
enum character_state_type {
	IDLE,
	IDLE_INSERT,
	MOVEMENT,
	ATTACK
	}

#----------------------------------------------------------------------------------------
#-----------------------------------------Ready------------------------------------------
#----------------------------------------------------------------------------------------

func _ready():
	_assign_character_states()
	_set_default_character_state()

func _assign_character_states():
	for state in states:
		if state.character_state_type == character_state_type.IDLE:
			idle_states.append(state)
		elif state.character_state_type == character_state_type.IDLE_INSERT:
			idle_insert_states.append(state)
		elif state.character_state_type == character_state_type.MOVEMENT:
			movement_states.append(state)
		elif state.character_state_type == character_state_type.ATTACK:
			attack_states.append(state)
			
	_debug_character_states()

func _set_default_character_state():
	current_character_state = idle_states[0]
	
	_debug_current_character_state(current_character_state)

#----------------------------------------------------------------------------------------
#----------------------------------Physics-Process---------------------------------------
#----------------------------------------------------------------------------------------

func _physics_process(_delta):
	_update_character_state()
	_handle_character_state()

func _update_character_state():
	if character_state_locked == false:
		if character_input.input_direction != Vector2.ZERO:
			_determine_movement_state()
			_debug_current_character_state(current_character_state)
		else:
			current_character_state = idle_states[0]
			_debug_current_character_state(current_character_state)

func _determine_movement_state():
	if(movement_manager.is_sprinting == true):
		current_character_state = movement_states[1]
	else:
		current_character_state = movement_states[0]

func _handle_character_state():
	character_animator.handle_animation(current_character_state)

#----------------------------------------------------------------------------------------
#---------------------------------------Debug--------------------------------------------
#----------------------------------------------------------------------------------------

func _debug_current_character_state(character_state: CharacterState):
	if debug_current_character_state_active:
		print("----------------------------------------")
		print("Current state: ", character_state.character_state_name)
		print("  Character state type: ", character_state.character_state_type)
		print("  Locks state: ", character_state.locks_character_state)
		print("")

func _debug_character_states():		
	if debug_character_states_active:
		print("---------Character States----------")
		if idle_states.size() > 0:
			for state in idle_states:
				print("Idle state: ", state.character_state_name)
		if idle_insert_states.size() > 0:
			for state in idle_insert_states:
				print("Idle insert state: ", state.character_state_name)
		if movement_states.size() > 0:
			for state in movement_states:
				print("Movement state: ", state.character_state_name)
		if attack_states.size() > 0:
			for state in attack_states:
				print("Attack state: ", state.character_state_name)
