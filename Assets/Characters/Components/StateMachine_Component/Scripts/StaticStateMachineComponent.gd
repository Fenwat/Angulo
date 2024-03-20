extends StateMachineComponent
class_name StaticStateMachineComponent

var idle_states: Array[EntityState]

var current_entity_state: EntityState

enum entity_state_type {
	IDLE
	}

func _ready():
	_assign_entity_states()
	_set_default_entity_state()

func _assign_entity_states():
	for state in entity_states.states_array:
		if state.entity_state_type == entity_state_type.IDLE:
			idle_states.append(state)

func _set_default_entity_state():
	current_entity_state = idle_states[0]

func _physics_process(_delta):
	_update_character_state()
	_handle_character_state()

func _update_character_state():
	if entity_state_locked == false:
		current_entity_state = idle_states[0]

func _handle_character_state():
	animator_component.handle_static_animation(current_entity_state)
