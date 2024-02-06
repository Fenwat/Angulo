extends Node2D
class_name NPCSchedule

@export var npc_events: NPCEvents
@export var npc_name: String

@onready var destination_navigator = $"../NavigationManager/DestinationNavigator"

func _ready():
	TimeSignalBus.connect("event_time_reached", compare_event_time)

func compare_event_time(time):
	#print("event_time received")
	for event in npc_events.events:
		if event.event_time == time:
			destination_debug(event)
			destination_navigator.do_travel_event(event)







#----------------------------------Debug----------------------------------------

func destination_debug(event):
	print("---" + npc_name + "'s New Destination---")
	print("Dest name: " + event.npc_destination_event.destination_name)
	print("Dest level: " + event.npc_destination_event.level)
	print("Dest coords: " + str(event.npc_destination_event.destination_coordinates))
	print("")
