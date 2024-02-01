extends Node2D

#@export var idle_time: float = 6.0
#@export var walk_time: float = 2.0
#
#@onready var farmer = $"../../.."
#@onready var timer = $"../../../Navigation/Timer"
#@onready var state_machine = $"../../StateMachine"
#@onready var navigation_manager = $".."
#
#func _ready():
	#select_new_direction()
#
#func _physics_process(_delta):
	#if state_machine.current_move_state != state_machine.MoveState.WALK:
		#return
	#
	#var new_velocity = navigation_manager.move_direction * navigation_manager.move_speed
	#farmer.velocity = new_velocity
	#
	#farmer.move_and_slide()
#
#func select_new_direction():
	#navigation_manager.move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	#
	#if navigation_manager.move_direction == Vector2.ZERO:
		#select_new_direction()
#
#func handle_idle_timer():
	#if timer.time_left == 0:
		#timer.start(idle_time)
		#select_new_direction()
	#
#func handle_walk_timer():
	#if timer.time_left == 0:
		#timer.start(walk_time)
#
#func _on_timer_timeout():
	#state_machine.switch_move_state()













#var movement_speed: float = 20.0
#var new_velocity: Vector2
#var number: int
#
#func _ready():
	#call_deferred("actor_setup")
#
#func actor_setup():
	#await get_tree().physics_frame
	#var random_target = get_random_point_in_polygon()
	#set_movement_target(random_target)
#
#func get_random_point_in_polygon():
	#randomize()
	#var nav_poly = farmer.navigation_region.navigation_polygon.get_polygon(number)
	#var point = Vector2()
	#while true:
		#point.x = randf_range(-1, 1)
		#point.y = randf_range(-1, 1)
		#return point
#
#func set_movement_target(target_point: Vector2):
	#farmer.navigation_agent.target_position = target_point
#
#func _physics_process(_delta):
	#if farmer.navigation_agent.is_navigation_finished():
		#new_velocity = Vector2.ZERO
		#return
	#calculate_new_velocity()
	#farmer.move_and_slide()
#
#func calculate_new_velocity():
	#var current_agent_position: Vector2 = global_position
	#var next_path_position: Vector2 = farmer.navigation_agent.get_next_path_position()
	#new_velocity = next_path_position - current_agent_position
	#new_velocity = new_velocity.normalized()
	#new_velocity = new_velocity * movement_speed
	#farmer.velocity = new_velocity


