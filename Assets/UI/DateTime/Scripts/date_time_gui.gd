extends Control
class_name DateTimeGui

func _ready():
	TimeSignalBus.connect("date_time_updated", handle_date_time_update)

func handle_date_time_update(current_game_time):
	var hour: int = current_game_time["time"]["hour"]
	var minute: int = current_game_time["time"]["minute"]
	var month: int = current_game_time["date"]["month"]
	var day: int = current_game_time["date"]["day"]
	var year: int = current_game_time["date"]["year"]

	# Now you can use the variables hour, minute, month, day, and year as integers in your function
	print("Current time: ", hour, ":", minute, "     Current date: ", month, "/", day, "/", year)
	#print("Month: ", month, " Day: ", day, " Year: ", year)

