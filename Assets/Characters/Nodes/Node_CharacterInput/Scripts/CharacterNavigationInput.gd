extends CharacterInput
class_name CharacterNavigationInput

@export var character_state_machine: CharacterStateMachine
@export var character_movement: CharacterMovement

@onready var character = $".."
@onready var navigation_agent = $"NavigationAgent2D"

var destination_coords: Vector2 = Vector2.ZERO
var is_navigating: bool = false

#------------------------------------------------------------------------------------------------------
#--------------------------------------Physics-Process-------------------------------------------------
#------------------------------------------------------------------------------------------------------

func _physics_process(_delta):
	_temp_movement_logic()
	_handle_navigation()

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
	character_state_machine.current_move_state = character_state_machine.MoveState.WALK
	move_to_position()

func get_new_coordinates(event):
	const tile_pixel_count: int = 8
	var adjusted_coords = (event.npc_destination_event.destination_coordinates * Vector2(tile_pixel_count, tile_pixel_count) + Vector2(tile_pixel_count / 2.0, tile_pixel_count / 2.0))
	destination_coords = adjusted_coords

func move_to_position():
	if destination_coords == Vector2.ZERO: return
	
	print(destination_coords)
	#navigation_agent.target_position = destination_coords

func _on_navigation_agent_2d_target_reached():
	is_navigating = false
	character_state_machine.determine_idle()
