extends Node2D
class_name TimeSystem

# Your existing variables
@export var game_calendar: GameCalendar
@export var date_time = DateTime

@onready var timer = $Timer

const BASE_YEAR = 9362

var print_timer = 0

signal date_time_updated(date_time: DateTime, date_time_as_seconds: float)

func _process(delta):
	print_timer += delta
	if print_timer >= 1.0:  # Print every 1 second
		var current_game_time: Vector2 = Vector2(date_time.game_time.game_hour, date_time.game_time.game_minute)
		
		# Assuming date_time and game_calendar are properly initialized and updated elsewhere
		var current_time = "{0}:{1}".format([date_time.game_time.game_hour, date_time.game_time.game_minute])
		var current_date = "{0}/{1}/{2}".format([date_time.game_date.month, date_time.game_date.day, date_time.game_date.year])
		
		TimeSignalBus.emit_signal("date_time_updated", current_game_time)
		
		print("Current Time: ", current_time, " Current Date: ", current_date)
		print_timer = 0  # Reset the timer

# Function to be called by the timer to increment game_minutes
func increment_game_minutes():
	date_time.game_time.game_minute += 1
	if date_time.game_time.game_minute > 59:
		date_time.game_time.game_minute = 0  # Reset minutes
		increment_game_hour()  # Increment hour since minutes overflowed

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
			increment_year()  # Increment year since months overflowed
	else:
		print("Year out of bounds: ", date_time.game_date.year)

# Function to increment year
func increment_year():
	date_time.game_date.year += 1
	# You may need to add logic here if your game_calendar has a specific range of years or other conditions

func _on_timer_timeout():
	increment_game_minutes() # Replace with function body.
