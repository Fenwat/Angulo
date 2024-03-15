extends Node
class_name CharacterAnimator

@export var character_input: CharacterInput

@onready var character = $".."
@onready var animation_tree = $"AnimationTree"
@onready var state_machine = animation_tree.get("parameters/playback")

var direction_locked: bool = false

# debug switches
var debug_current_animation_active: bool = false

func handle_animation(character_state: CharacterState):
	var blend_position: String = "parameters/" + character_state.character_state_name + "/blend_position"
	var animation_vector: Vector2 = Vector2.ZERO
	
	if character_input == null:
		_debug_current_animation(character_state)
		animation_tree.set("parameters/" + character_state.character_state_name, Vector2.ZERO)
		return
		
	if direction_locked: return
	
	if character_state.is_static:
		animation_vector = character_input.last_non_zero_input
	else:
		animation_vector = character_input.input_direction
	
	state_machine.travel(character_state.character_state_name)
	
	_set_animation_blend_position(blend_position, animation_vector)
	_debug_current_animation(character_state)

func _set_animation_blend_position(path, move_input):
	animation_tree.set(path, move_input)

func handle_static_animation(character_state: CharacterState):
	state_machine.travel(character_state.character_state_name)

#-----------------------------------------Debug--------------------------------------------

func _debug_current_animation(character_state: CharacterState):
	if debug_current_animation_active:
		print(character.character_name, "'s current animation: ", character_state.character_state_name, "   |   Animation locked: ", character_state.locks_character_state)
