extends Node
class_name AnimatorComponent

@export var input_component: InputComponent

@onready var entity = $".."
@onready var animation_tree = $"AnimationTree"
@onready var state_machine = animation_tree.get("parameters/playback")

var direction_locked: bool = false

# debug switches
var debug_current_animation_active: bool = false

func handle_animation(entity_state: EntityState):
	var blend_position: String = "parameters/" + entity_state.entity_state_name + "/blend_position"
	var animation_vector: Vector2 = Vector2.ZERO
	
	if input_component == null:
		_debug_current_animation(entity_state)
		animation_tree.set("parameters/" + entity_state.entity_state_name, Vector2.ZERO)
		return
		
	if direction_locked: return
	
	if entity_state.is_static:
		animation_vector = input_component.last_non_zero_input
	else:
		animation_vector = input_component.input_direction
	
	state_machine.travel(entity_state.entity_state_name)
	
	_set_animation_blend_position(blend_position, animation_vector)
	_debug_current_animation(entity_state)

func _set_animation_blend_position(path, move_input):
	animation_tree.set(path, move_input)

func handle_static_animation(entity_state: EntityState):
	state_machine.travel(entity_state.entity_state_name)

#-----------------------------------------Debug--------------------------------------------

func _debug_current_animation(entity_state: EntityState):
	if debug_current_animation_active:
		print(entity.entity_name, "'s current animation: ", entity_state.entity_state_name, "   |   Animation locked: ", entity_state.locks_character_state)
