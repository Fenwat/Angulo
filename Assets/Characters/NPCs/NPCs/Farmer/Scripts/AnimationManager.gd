extends Node

@onready var farmer = $"../.."
@onready var state_machine = $"../StateMachine"
@onready var navigation_manager = $"../NavigationManager"
@onready var animation_tree = $"../../AnimationTree"
@onready var animation_state_machine = animation_tree.get("parameters/playback")

func handle_idle_animation():
	animation_state_machine.travel("Idle")
	set_animation_blend_position("parameters/Idle/blend_position", navigation_manager.last_non_zero_input)

func handle_walk_animation():
	animation_state_machine.travel("Walk")
	if(navigation_manager.direction != Vector2.ZERO):
		set_animation_blend_position("parameters/Walk/blend_position", navigation_manager.direction)

func handle_straw_animation():
	animation_state_machine.travel("Straw")
	set_animation_blend_position("parameters/Straw/blend_position", navigation_manager.last_non_zero_input)

func handle_forage_animation():
	animation_state_machine.travel("Forage")
	set_animation_blend_position("parameters/Forage/blend_position", navigation_manager.last_non_zero_input)

func set_animation_blend_position(path, move_input):
	animation_tree.set(path, move_input)
