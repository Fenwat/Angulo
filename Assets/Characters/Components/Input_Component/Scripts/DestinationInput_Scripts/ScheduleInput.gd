extends Node
class_name ScheduleComponent

@export var schedule_events: NPCEvents

@onready var entity = $"../.."
@onready var entity_destination_input = $".."

func _ready():
	_connect_signals()
	_connect_schedule()

func _connect_signals():
	TimeSignalBus.connect("event_time_reached", compare_event_time)

func _connect_schedule():
	if entity.entity_schedule_events == null: return
	
	schedule_events = entity.entity_schedule_events

func compare_event_time(time):
	if schedule_events == null: return
	#print("event_time received")
	for event in schedule_events.events:
		if event.event_time == time:
			#destination_debug(event)
			entity_destination_input.do_travel_event(event)
