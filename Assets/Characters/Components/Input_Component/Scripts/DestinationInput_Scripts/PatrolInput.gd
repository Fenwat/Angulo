extends Node
class_name PatrolComponent

@onready var patrol_events: NPCEvents
@onready var entity = $"../.."
@onready var entity_destination_input = $".."
@onready var timer = $Timer

var current_event_index: int = 0
var current_event: NPCEvent

func _ready():
	_connect_npc_events()
	_set_current_event()
	call_deferred("_process_next_destination")

func _connect_npc_events():
	patrol_events = entity.character_patrol_events

func _set_current_event():
	if patrol_events == null: return
	
	current_event = patrol_events.events[current_event_index]

func _process_next_destination():
	entity_destination_input.do_travel_event(current_event)

func _on_navigation_agent_2d_target_reached():
	_start_event_timer()

func _start_event_timer():
	var timer_duration = current_event.npc_destination_event.destination_duration
	timer.wait_time = timer_duration
	timer.start()
	
	_iterate_current_destination()

func _iterate_current_destination():
	if current_event_index == patrol_events.events.size() - 1:
		current_event_index = 0
	else:
		current_event_index += 1
	
	_set_current_event()

func _on_timer_timeout():
	_process_next_destination()
