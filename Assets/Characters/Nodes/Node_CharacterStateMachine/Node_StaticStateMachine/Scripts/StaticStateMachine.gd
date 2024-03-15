extends CharacterStateMachine
class_name StaticStateMachine

var idle_states: Array[CharacterState]

var current_character_state: CharacterState

enum character_state_type {
	IDLE
	}

func _ready():
	_assign_character_states()
	_set_default_character_state()

func _assign_character_states():
	for state in states:
		if state.character_state_type == character_state_type.IDLE:
			idle_states.append(state)

func _set_default_character_state():
	current_character_state = idle_states[0]

func _physics_process(_delta):
	_update_character_state()
	_handle_character_state()

func _update_character_state():
	if character_state_locked == false:
		current_character_state = idle_states[0]

func _handle_character_state():
	character_animator.handle_static_animation(current_character_state)
