extends Node2D
class_name TimeSystem

@export var game_calendar: GameCalendar
@export var date_time: DateTime

@onready var timer = $Timer

const BASE_YEAR = 9362

var print_timer = 0
var event_time: String
var hour_string: String
var minute_string: String

func _ready():
	call_deferred("signal_initial_date")
	call_deferred("handle_event_time")

#---------------------------Event Time-----------------------------------------------

func handle_event_time():
	determine_hour_string()
	determine_minute_string()
	event_time = hour_string + ":" + minute_string
	signal_event_time()
	
func signal_event_time():
	if date_time.game_time.game_minute % 5 == 0:
		TimeSignalBus.emit_signal("event_time_reached", event_time)
		

func determine_hour_string():
	if len(str(date_time.game_time.game_hour)) == 1:
		hour_string = "0" + str(date_time.game_time.game_hour)
	else:
		hour_string = str(date_time.game_time.game_hour)

func determine_minute_string():
	if len(str(date_time.game_time.game_minute)) == 1:
		minute_string = "0" + str(date_time.game_time.game_minute)
	else:
		minute_string = str(date_time.game_time.game_minute)

#---------------------------Current Date---------------------------------------------

func signal_initial_date():
	var initial_game_date: GameDate = date_time.game_date
	var initial_month = date_time.game_date.month - 1
	var initial_month_name = get_current_month(initial_month)
	TimeSignalBus.emit_signal("initial_date_set", initial_game_date, initial_month_name)

func signal_current_day():
	var new_game_date: GameDate = date_time.game_date
	TimeSignalBus.emit_signal("date_changed", new_game_date)

func signal_new_month():
	var new_month = date_time.game_date.month - 1
	var new_month_name = get_current_month(new_month)
	TimeSignalBus.emit_signal("new_month_reached", new_month_name)

func get_current_month(current_month):
	var year_index = date_time.game_date.year - BASE_YEAR
	var current_month_name = game_calendar.game_year[year_index].months[current_month].display_name
	return current_month_name

#---------------------------Time increment--------------------------------------------

# Function called by the timer to increment game_minutes
func increment_game_minutes():
	date_time.game_time.game_minute += 1
	if date_time.game_time.game_minute > 59:
		date_time.game_time.game_minute = 0  # Reset minutes
		increment_game_hour()  # Increment hour since minutes overflowed
	handle_event_time()

# Function to increment game_hour and handle overflow
func increment_game_hour():
	date_time.game_time.game_hour += 1
	if date_time.game_time.game_hour > 23:
		date_time.game_time.game_hour = 0  # Reset hour
		increment_day()  # Increment day since hours overflowed

# Function to increment day and handle overflow
func increment_day():
	date_time.game_date.day += 1
	var year_index = date_time.game_date.year - BASE_YEAR  # Calculate the index based on the base year
	# Get the number of days in the current month from game_calendar
	if year_index >= 0 and year_index < game_calendar.game_year.size():
		var months = game_calendar.game_year[year_index].months
		if date_time.game_date.month - 1 >= 0 and date_time.game_date.month - 1 < months.size():
			var days_in_month = months[date_time.game_date.month - 1].days
			if date_time.game_date.day > days_in_month:
				date_time.game_date.day = 1  # Reset day
				signal_current_day()
				increment_month()  # Increment month since days overflowed
	else:
		print("Year out of bounds: ", date_time.game_date.year)

# Function to increment month and handle overflow
func increment_month():
	date_time.game_date.month += 1
	var year_index = date_time.game_date.year - BASE_YEAR  # Calculate the index based on the base year
	# Check if the year_index is within the bounds of the game_year array
	if year_index >= 0 and year_index < game_calendar.game_year.size():
		var months_in_year = game_calendar.game_year[year_index].months.size()
		if date_time.game_date.month > months_in_year:
			date_time.game_date.month = 1  # Reset month
			signal_new_month()
			increment_year()  # Increment year since months overflowed
	else:
		print("Year out of bounds: ", date_time.game_date.year)

# Function to increment year
func increment_year():
	date_time.game_date.year += 1
	# You may need to add logic here if your game_calendar has a specific range of years or other conditions

func _on_timer_timeout():
	increment_game_minutes()
