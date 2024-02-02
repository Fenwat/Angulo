extends Control
class_name DateTimeGui

@onready var time_label = $Time_NinePatchRect/Panel/Label

var hour: int
var minute: int
var month: int
var day: int
var year: int

var time: String
var date: String

var hour_string: String
var minute_string: String

func _ready():
	#TimeSignalBus.connect("date_time_updated", handle_date_time_update)
	TimeSignalBus.connect("event_time_reached", handle_event_time)

func handle_event_time(event_time):
	time_label.text = event_time
