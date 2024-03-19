extends StateMachineComponent
class_name DynamicStateMachineComponent

@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var inventory_component: InventoryComponent

# EntityState storage arrays 
var idle_states: Array[EntityState]
var idle_insert_states: Array[EntityState]
var movement_states: Array[EntityState]
var attack_states: Array[EntityState]
var light_attack_states: Array[EntityState]
var heavy_attack_states: Array[EntityState]

var current_entity_state: EntityState

# Attack indexing variables
var attack_queued: bool = false
var attack_in_progress: bool = false
var current_attack_index: int = 0

# Toggle debugs
var debug_current_entity_state_active: bool = false
var debug_entity_states_active: bool = false

# Needs to be identical to the enum in the EntityState class. Order matters.
enum entity_state_type {
	IDLE,
	IDLE_INSERT,
	MOVEMENT,
	ATTACK
	}

enum attack_state_type {
	LIGHT,
	HEAVY
	}

#----------------------------------------------------------------------------------------
#-----------------------------------------Ready------------------------------------------
#----------------------------------------------------------------------------------------

func _ready():
	_assign_entity_states()
	_set_default_entity_state()


func _assign_entity_states():
	for state in entity_states.states_array:
		if state.entity_state_type == entity_state_type.IDLE:
			idle_states.append(state)
		elif state.entity_state_type == entity_state_type.IDLE_INSERT:
			idle_insert_states.append(state)
		elif state.entity_state_type == entity_state_type.MOVEMENT:
			movement_states.append(state)
		elif state.entity_state_type == entity_state_type.ATTACK:
			attack_states.append(state)
			_assign_entity_attack_state(state)
			
	_debug_entity_states()

func _set_default_entity_state():
	current_entity_state = idle_states[0]
	
	_debug_current_entity_state(current_entity_state)

func _assign_entity_attack_state(state: EntityState):
	if state.attack_data.attack_type == attack_state_type.LIGHT:
		if state.attack_data.part_of_string_attack:
			light_attack_states.insert(state.attack_data.attack_index, state)
	elif state.attack_data.attack_type == attack_state_type.HEAVY:
		heavy_attack_states.append(state)

#----------------------------------------------------------------------------------------
#----------------------------------Physics-Process---------------------------------------
#----------------------------------------------------------------------------------------

func _physics_process(_delta):
	_update_character_state()
	_handle_character_state()

func _update_character_state():
	if entity_state_locked == false:
		if input_component == null: return
		
		if input_component.input_direction != Vector2.ZERO:
			_determine_movement_state()
			_debug_current_entity_state(current_entity_state)
		else:
			current_entity_state = idle_states[0]
			_debug_current_entity_state(current_entity_state)

func _determine_movement_state():
	if(movement_component.is_sprinting == true):
		current_entity_state = movement_states[1]
	else:
		current_entity_state = movement_states[0]

func _handle_character_state():
	animator_component.handle_animation(current_entity_state)

#----------------------------------------------------------------------------------------
#-----------------------------------Input-Triggered--------------------------------------
#----------------------------------------------------------------------------------------

#---------------------------------------Tools-------------------------------------------

func lock_character():
	entity_state_locked = true
	movement_component.position_locked = true
	movement_component.current_character_direction_locked = true
	animator_component.direction_locked = true

func unlock_character():
	entity_state_locked = false
	movement_component.position_locked = false
	movement_component.current_character_direction_locked = false
	animator_component.direction_locked = false

func _check_for_attack():
	if attack_in_progress:
		attack_queued = true
	else:
		attack_in_progress = true

func _handle_attack_state(attack_state_array: Array):
	current_entity_state = attack_state_array[current_attack_index]
	animator_component.handle_animation(current_entity_state)

#------------------------------------Light-Attack----------------------------------------

func handle_light_attack():
	if light_attack_states.size() == 0: return
	
	if inventory_component.menu_is_open: return
	
	_check_for_attack()
	
	if current_attack_index > light_attack_states.size() - 1:
		current_attack_index = 0
	
	_handle_attack_state(light_attack_states)
	lock_character()

func light_attack_finished():
	attack_in_progress = false
	if attack_queued:
		attack_queued = false
		current_attack_index += 1
		movement_component.move_character(current_entity_state)
		unlock_character()
		handle_next_light_attack()
	else:
		attack_queued = false
		current_attack_index = 0
		unlock_character()

func handle_next_light_attack():
	handle_light_attack()

#----------------------------------------------------------------------------------------
#---------------------------------------Debug--------------------------------------------
#----------------------------------------------------------------------------------------

func _debug_current_entity_state(entity_state: EntityState):
	if debug_current_entity_state_active:
		print("--------------", entity.entity_name, "---------------")
		print("Current state: ", entity_state.entity_state_name)
		print("  Entity state type: ", entity_state.entity_state_type)
		print("  Locks state: ", entity_state.locks_entity_state)
		print("")

func _debug_entity_states():
	
	if debug_entity_states_active:
		print("----", entity.entity_name, " Entity States-------")
		if idle_states.size() > 0:
			for state in idle_states:
				print("Idle state: ", state.entity_state_name)
		if idle_insert_states.size() > 0:
			for state in idle_insert_states:
				print("Idle insert state: ", state.entity_state_name)
		if movement_states.size() > 0:
			for state in movement_states:
				print("Movement state: ", state.entity_state_name)
		if attack_states.size() > 0:
			for state in attack_states:
				print("Attack state: ", state.entity_state_name)
