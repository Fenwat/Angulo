extends Node2D

@onready var farmer = $"../.."
@onready var animation_manager = $"../AnimationManager"
@onready var navigation_manager = $"../NavigationManager"
@onready var random_navigator = $"../NavigationManager/RandomNavigator"

enum MoveState {
	IDLE,
	WALK,
	STRAW,
	FORAGE
}

enum NavigatorState {
	DESTINATION,
	RANDOM
}

var current_move_state = MoveState.IDLE
var current_navigator_state = NavigatorState.DESTINATION

var move_state_locked: bool = false
var navigator_state_locked: bool = false

#-------------------------------Move-State---------------------------------------

func _ready():
	update_move_state()
	update_navigator_state()

func switch_move_state():
	if current_move_state != MoveState.WALK:
		current_move_state = MoveState.WALK
		update_move_state()
	else:
		determine_idle()
		update_move_state()

func update_move_state():
	if move_state_locked:
		return
		
	match current_move_state:
		MoveState.IDLE:
			handle_idle_state()
		MoveState.WALK:
			handle_walk_state()
		MoveState.STRAW:
			handle_straw_state()
		MoveState.FORAGE:
			handle_forage_state()

func determine_idle():
	if farmer.is_farming:
		current_move_state = MoveState.FORAGE
	else:
		current_move_state = MoveState.IDLE

func handle_idle_state():
	animation_manager.handle_idle_animation()
	if current_navigator_state == NavigatorState.RANDOM:
		random_navigator.handle_idle_timer()

func handle_walk_state():
	animation_manager.handle_walk_animation()
	if current_navigator_state == NavigatorState.RANDOM:
		random_navigator.handle_walk_timer()

func handle_straw_state():
	animation_manager.handle_straw_animation()
	if current_navigator_state == NavigatorState.RANDOM:
		random_navigator.handle_idle_timer()

func handle_forage_state():
	animation_manager.handle_forage_animation()
	if current_navigator_state == NavigatorState.RANDOM:
		random_navigator.handle_idle_timer()

#----------------------------Navigator-State-------------------------------------

func update_navigator_state():
	if navigator_state_locked:
		return
		
	match current_navigator_state:
		NavigatorState.DESTINATION:
			handle_destination_state()
		NavigatorState.RANDOM:
			handle_random_state()

func handle_destination_state():
	pass

func handle_random_state():
	pass
