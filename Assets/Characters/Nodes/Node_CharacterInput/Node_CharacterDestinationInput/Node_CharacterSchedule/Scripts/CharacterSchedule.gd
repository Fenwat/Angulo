extends Node
class_name CharacterSchedule

@export var npc_events: NPCEvents

@onready var character_destination_input = $".."

func _ready():
	TimeSignalBus.connect("event_time_reached", compare_event_time)

func compare_event_time(time):
	#print("event_time received")
	for event in npc_events.events:
		if event.event_time == time:
			#destination_debug(event)
			character_destination_input.do_travel_event(event)
