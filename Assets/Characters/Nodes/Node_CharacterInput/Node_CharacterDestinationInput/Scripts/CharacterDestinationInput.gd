extends CharacterInput
class_name CharacterDestinationInput

@export var character_state_machine: CharacterStateMachine
@export var character_movement: CharacterMovement
@export var navigation_agent: NavigationAgent2D

@export var path_desired_distance: float = 1.0
@export var target_desired_distance: float = 1.0

@onready var character = $".."
#@onready var navigation_agent = $"NavigationAgent2D"

var destination_coords: Vector2 = Vector2.ZERO
var is_navigating: bool = false

#------------------------------------------------------------------------------------------------------
#--------------------------------------Physics-Process-------------------------------------------------
#------------------------------------------------------------------------------------------------------

func _physics_process(_delta):
	_handle_navigation()
	_get_last_non_zero_input()

func _get_last_non_zero_input():
	if input_direction != Vector2.ZERO:
		last_non_zero_input = input_direction

func _temp_movement_logic():
	input_direction = Vector2(0, 0.5)

func _handle_navigation():
	if not is_navigating: return
	
	if navigation_agent.is_navigation_finished(): return
	
	input_direction = to_local(navigation_agent.get_next_path_position()).normalized()

#------------------------------------------------------------------------------------------------------
#---------------------------------------Travel-Events--------------------------------------------------
#------------------------------------------------------------------------------------------------------

func do_travel_event(event):
	is_navigating = true
	get_new_coordinates(event)
	move_to_position()

func get_new_coordinates(event):
	if event == null: return
	
	const tile_pixel_count: int = 8
	var adjusted_coords = (event.npc_destination_event.destination_coordinates * Vector2(tile_pixel_count, tile_pixel_count) + Vector2(tile_pixel_count / 2.0, tile_pixel_count / 2.0))
	destination_coords = adjusted_coords

func move_to_position():
	if destination_coords == Vector2.ZERO: return
	
	if navigation_agent == null: return
	
	navigation_agent.target_position = destination_coords

func _on_navigation_agent_2d_target_reached():
	is_navigating = false
	input_direction = Vector2.ZERO
