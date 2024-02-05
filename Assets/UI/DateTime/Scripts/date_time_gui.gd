extends Control
class_name DateTimeGui

@onready var time_label = $Time_NinePatchRect/Panel/Label
@onready var day_label = $Day_NinePatchRect/Panel/Label
@onready var month_label = $Month_NinePatchRect/Panel/Label

func _ready():
	TimeSignalBus.connect("initial_date_set", set_initial_date)
	TimeSignalBus.connect("event_time_reached", handle_event_time)
	TimeSignalBus.connect("date_changed", handle_date_changed)
	TimeSignalBus.connect("new_month_reached", update_month_name)

func set_initial_date(initial_game_date, initial_month_name):
	var initial_day = str(initial_game_date.day)
	if len(initial_day) == 1:
		initial_day = "0" + initial_day
	day_label.text = initial_day
	month_label.text = initial_month_name

func handle_event_time(event_time):
	time_label.text = event_time

func handle_date_changed(new_game_date):
	var new_day = str(new_game_date.day)
	if len(new_day) == 1:
		new_day = "0" + new_day
	day_label.text = new_day

func update_month_name(new_month_name):
	print("updateing month")
	month_label.text = new_month_name
