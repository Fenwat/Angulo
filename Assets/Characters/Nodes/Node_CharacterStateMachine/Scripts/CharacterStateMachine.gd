extends Node
class_name CharacterStateMachine

@export var character_animator: CharacterAnimator
@export var character_inventory: CharacterInventory

## Array of all character states. Order does not matter.
@export var states: Array[CharacterState]

@onready var character = $".."
@onready var current_character_type = character.character_type

var character_state_locked: bool = false

## CharacterState storage arrays 
#var idle_states: Array[CharacterState]
#var idle_insert_states: Array[CharacterState]
#var movement_states: Array[CharacterState]
#var attack_states: Array[CharacterState]
#var light_attack_states: Array[CharacterState]
#var heavy_attack_states: Array[CharacterState]
#
#var current_character_state: CharacterState
#
## Attack indexing variables
#var attack_queued: bool = false
#var attack_in_progress: bool = false
#var current_attack_index: int = 0
#
## Toggle debugs
#var debug_current_character_state_active: bool = true
#var debug_character_states_active: bool = false
#
## Needs to be identical to the enum in the CharacterState class. Order matters.
#enum character_state_type {
	#IDLE,
	#IDLE_INSERT,
	#MOVEMENT,
	#ATTACK
	#}
#
#enum attack_state_type {
	#LIGHT,
	#HEAVY
	#}
#
##----------------------------------------------------------------------------------------
##-----------------------------------------Ready------------------------------------------
##----------------------------------------------------------------------------------------
#
#func _ready():
	#_assign_character_states()
	#_set_default_character_state()
#
#
#func _assign_character_states():
	#for state in states:
		#if state.character_state_type == character_state_type.IDLE:
			#idle_states.append(state)
		#elif state.character_state_type == character_state_type.IDLE_INSERT:
			#idle_insert_states.append(state)
		#elif state.character_state_type == character_state_type.MOVEMENT:
			#movement_states.append(state)
		#elif state.character_state_type == character_state_type.ATTACK:
			#attack_states.append(state)
			#_assign_character_attack_state(state)
			#
	#_debug_character_states()
#
#func _set_default_character_state():
	#current_character_state = idle_states[0]
	#
	#_debug_current_character_state(current_character_state)
#
#func _assign_character_attack_state(state: CharacterState):
	#if state.attack_data.attack_type == attack_state_type.LIGHT:
		#if state.attack_data.part_of_string_attack:
			#light_attack_states.insert(state.attack_data.attack_index, state)
	#elif state.attack_data.attack_type == attack_state_type.HEAVY:
		#heavy_attack_states.append(state)
#
##----------------------------------------------------------------------------------------
##----------------------------------Physics-Process---------------------------------------
##----------------------------------------------------------------------------------------
#
#func _physics_process(_delta):
	#_update_character_state()
	#_handle_character_state()
#
#func _update_character_state():
	#if character_state_locked == false:
		#if character_input == null: return
		#
		#if character_input.input_direction != Vector2.ZERO:
			#_determine_movement_state()
			#_debug_current_character_state(current_character_state)
		#else:
			#current_character_state = idle_states[0]
			#_debug_current_character_state(current_character_state)
#
#func _determine_movement_state():
	#if(character_movement.is_sprinting == true):
		#current_character_state = movement_states[1]
	#else:
		#current_character_state = movement_states[0]
#
#func _handle_character_state():
	#character_animator.handle_animation(current_character_state)
#
##----------------------------------------------------------------------------------------
##-----------------------------------Input-Triggered--------------------------------------
##----------------------------------------------------------------------------------------
#
##---------------------------------------Tools-------------------------------------------
#
#func lock_character():
	#character_state_locked = true
	#character_movement.position_locked = true
	#character_animator.direction_locked = true
#
#func unlock_character():
	#character_state_locked = false
	#character_movement.position_locked = false
	#character_animator.direction_locked = false
#
#func _check_for_attack():
	#if attack_in_progress:
		#attack_queued = true
	#else:
		#attack_in_progress = true
#
#func _handle_attack_state(attack_state_array: Array):
	#current_character_state = attack_state_array[current_attack_index]
	#character_animator.handle_animation(current_character_state)
#
##------------------------------------Light-Attack----------------------------------------
#
#func handle_light_attack():
	#if light_attack_states.size() == 0: return
	#
	#if character_inventory.menu_is_open: return
	#
	#_check_for_attack()
	#
	#if current_attack_index > light_attack_states.size() - 1:
		#current_attack_index = 0
	#
	#_handle_attack_state(light_attack_states)
	#lock_character()
#
#func light_attack_finished():
	#attack_in_progress = false
	#if attack_queued:
		#attack_queued = false
		#current_attack_index += 1
		#character_movement.move_character(current_character_state)
		#unlock_character()
		#handle_next_light_attack()
	#else:
		#attack_queued = false
		#current_attack_index = 0
		#unlock_character()
#
#func handle_next_light_attack():
	#handle_light_attack()
#
##----------------------------------------------------------------------------------------
##---------------------------------------Debug--------------------------------------------
##----------------------------------------------------------------------------------------
#
#func _debug_current_character_state(character_state: CharacterState):
	#if debug_current_character_state_active:
		#print("--------------", character.character_name, "---------------")
		#print("Current state: ", character_state.character_state_name)
		#print("  Character state type: ", character_state.character_state_type)
		#print("  Locks state: ", character_state.locks_character_state)
		#print("")
#
#func _debug_character_states():
	#
	#if debug_character_states_active:
		#print("----", character.character_name, " Character States-------")
		#if idle_states.size() > 0:
			#for state in idle_states:
				#print("Idle state: ", state.character_state_name)
		#if idle_insert_states.size() > 0:
			#for state in idle_insert_states:
				#print("Idle insert state: ", state.character_state_name)
		#if movement_states.size() > 0:
			#for state in movement_states:
				#print("Movement state: ", state.character_state_name)
		#if attack_states.size() > 0:
			#for state in attack_states:
				#print("Attack state: ", state.character_state_name)
