extends Node
class_name CharacterPatrol

@export var npc_events: NPCEvents

@onready var character_destination_input = $".."
@onready var timer = $Timer

var current_event: NPCEvent

func _ready():
	_select_initial_destination()
	_process_next_destination()

func _select_initial_destination():
	current_event = npc_events.events[0]

func _process_next_destination():
	character_destination_input.do_travel_event(current_event)

func _start_event_timer():
	pass
