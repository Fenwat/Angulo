extends Node
class_name CharacterAnimator

@onready var character_input = $"../CharacterInput"
@onready var input_manager = $"../InputManager"
@onready var animation_tree = $"AnimationTree"
@onready var state_machine = animation_tree.get("parameters/playback")

var debug_current_animation_active: bool = false

func handle_animation(character_state: CharacterState):
	var blend_position: String = "parameters/" + character_state.character_state_name + "/blend_position"
	var animation_vector: Vector2 = Vector2.ZERO
	
	if character_state.is_static:
		animation_vector = character_input.last_non_zero_input
	else:
		animation_vector = character_input.input_direction
	
	state_machine.travel(character_state.character_state_name)
	
	_set_animation_blend_position(blend_position, animation_vector)
	_debug_current_animation(character_state)

func _set_animation_blend_position(path, move_input):
	animation_tree.set(path, move_input)

#-----------------------------------------Debug--------------------------------------------

func _debug_current_animation(character_state: CharacterState):
	if debug_current_animation_active:
		print("Current animation: ", character_state.character_state_name, "   |   Animation locked: ", character_state.locks_character_state)
