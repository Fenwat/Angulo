extends Node
class_name CharacterSchedule

@export var schedule_events: NPCEvents

@onready var character = $"../.."
@onready var character_destination_input = $".."

func _ready():
	_connect_signals()
	_connect_schedule()

func _connect_signals():
	TimeSignalBus.connect("event_time_reached", compare_event_time)

func _connect_schedule():
	schedule_events = character.character_schedule_events

func compare_event_time(time):
	if schedule_events == null: return
	#print("event_time received")
	for event in schedule_events.events:
		if event.event_time == time:
			#destination_debug(event)
			character_destination_input.do_travel_event(event)
