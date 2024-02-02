extends Control
class_name DateTimeGui

func _ready():
	Signals.connect("item_equipped", Callable(self, "_call_function_by_name"))
	#time_signal_bus.date_time_updated.connect(print_stuff)
	TimeSignalBus.connect("date_time_updated", print_stuff)

func print_stuff(current_game_time):
	print(current_game_time)
