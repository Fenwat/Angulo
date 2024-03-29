extends Node2D

@onready var farmer = $"../../.."
@onready var state_machine = $"../../StateMachine"
@onready var navigation_manager = $".."
@onready var navigation_agent = $"../../../Navigation/NavigationAgent2D"

var destination_coords: Vector2 = Vector2.ZERO

func _process(_delta):
	state_machine.update_move_state()
	#var farmer_local_position = farmer.position
	#var _map_coords = farmer.map.local_to_map(farmer_local_position)

func _physics_process(_delta):	
	if navigation_agent.is_navigation_finished(): return
	
	navigation_manager.move_direction = to_local(navigation_agent.get_next_path_position()).normalized()
	farmer.velocity = navigation_manager.move_direction * navigation_manager.move_speed
	
	farmer.move_and_slide()

func do_travel_event(event):
	get_new_coordinates(event)
	state_machine.current_move_state = state_machine.MoveState.WALK
	move_to_position()

func get_new_coordinates(event):
	const tile_pixel_count: int = 8
	var adjusted_coords = (event.npc_destination_event.destination_coordinates * Vector2(tile_pixel_count, tile_pixel_count) + Vector2(tile_pixel_count / 2.0, tile_pixel_count / 2.0))
	destination_coords = adjusted_coords

func move_to_position():
	if destination_coords == Vector2.ZERO:
		return
	
	navigation_agent.target_position = destination_coords

func _on_navigation_agent_2d_target_reached():
	state_machine.determine_idle()
