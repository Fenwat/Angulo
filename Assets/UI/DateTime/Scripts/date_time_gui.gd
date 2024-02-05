extends Control
class_name DateTimeGui

@onready var time_label = $Time_NinePatchRect/Panel/Label
@onready var day_label = $Day_NinePatchRect/Panel/Label

func _ready():
	#TimeSignalBus.connect("date_time_updated", handle_date_time_update)
	TimeSignalBus.connect("event_time_reached", handle_event_time)
	TimeSignalBus.connect("date_changed", handle_date_changed)

func handle_event_time(event_time):
	time_label.text = event_time

func handle_date_changed(new_game_date):
	var new_day = str(new_game_date.day)
	if len(new_day) == 1:
		new_day = "0" + new_day
	day_label.text = new_day
	
