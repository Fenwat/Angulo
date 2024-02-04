extends Control
class_name DateTimeGui

@onready var time_label = $Time_NinePatchRect/Panel/Label

func _ready():
	#TimeSignalBus.connect("date_time_updated", handle_date_time_update)
	TimeSignalBus.connect("event_time_reached", handle_event_time)
	TimeSignalBus.connect("date_changed", handle_date_changed)

func handle_event_time(event_time):
	time_label.text = event_time

func handle_date_changed(new_game_date):
	print(new_game_date.day)
