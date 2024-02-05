extends Node2D

@onready var destination_navigator = $"../NavigationManager/DestinationNavigator"

func _ready():
	TimeSignalBus.connect("event_time_reached", handle_event_time)

func handle_event_time(event_time):
	match event_time:
		"09:00":
			destination_navigator.destination_name = "field"
		"09:30":
			destination_navigator.destination_name = "farm_house"
		"10:15":
			destination_navigator.destination_name = "field"
		"11:00":
			destination_navigator.destination_name = "square"
		"11:45":
			destination_navigator.destination_name = "field"
		"12:30":
			destination_navigator.destination_name = "farm_house"
		"13:00":
			destination_navigator.destination_name = "field"
		"13:45":
			destination_navigator.destination_name = "farm_house"
		"14:30":
			destination_navigator.destination_name = "field"
		"15:00":
			destination_navigator.destination_name = "farm_house"
		"16:00":
			destination_navigator.destination_name = "square"
		"17:00":
			destination_navigator.destination_name = "farm_house"
		_:
			return  # Handle unexpected time or default case if necessary
			
	destination_navigator.handle_travel_event()
