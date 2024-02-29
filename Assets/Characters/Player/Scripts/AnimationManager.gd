extends Node

@onready var input_manager = $"../InputManager"
@onready var movement_manager = $"../MovementManager"
@onready var animation_tree = $"../../AnimationTree"
@onready var state_machine = animation_tree.get("parameters/playback")

var current_animation = AnimationState.IDLE

var input_direction: Vector2 = Vector2.ZERO
var last_non_zero_input: Vector2 = Vector2(0, 0.1)

var animation_lock: bool = false

enum AnimationState {
	IDLE,
	WALK,
	RUN
}

func _physics_process(_delta):
	input_direction = input_manager.direction
	if input_direction != Vector2.ZERO:
		last_non_zero_input = input_direction
	update_animation()
	handle_animation(input_direction)

func update_animation():
	if(animation_lock == false):
		if(input_direction != Vector2.ZERO):
			choose_movement_input_animation()
		else:
			current_animation = AnimationState.IDLE

func choose_movement_input_animation():
	if(movement_manager.is_sprinting == true):
		current_animation = AnimationState.RUN
	else:
		current_animation = AnimationState.WALK

func handle_animation(move_input: Vector2):
	match current_animation:
		AnimationState.IDLE:
			if(animation_lock == false):
				_handle_idle_animation(move_input)
		AnimationState.WALK:
			if(animation_lock == false):
				_handle_walk_animation(move_input)
		AnimationState.RUN:
			if(animation_lock == false):
				_handle_run_animation(move_input)

func _handle_idle_animation(_move_input):
	state_machine.travel("Idle")
	set_animation_blend_position("parameters/Idle/blend_position",  last_non_zero_input)

func _handle_walk_animation(move_input):
	state_machine.travel("Walk")
	if(move_input != Vector2.ZERO):
		set_animation_blend_position("parameters/Walk/blend_position", move_input)

func _handle_run_animation(move_input):
	state_machine.travel("Run")
	if(move_input != Vector2.ZERO):
		set_animation_blend_position("parameters/Run/blend_position", move_input)

func set_animation_blend_position(path, move_input):
	animation_tree.set(path, move_input)

#--------------------------------New-Animation-Manager-------------------------------

func _handle_animation(move_input, state_name):
	var blend_position: String = "parameters/" + state_name + "/blend_position"
	
	state_machine.travel(state_name)
	set_animation_blend_position(blend_position, move_input)
