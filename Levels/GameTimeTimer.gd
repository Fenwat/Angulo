extends Timer

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0  # Set to however long you want each "game minute" to be in real time
	timer.autostart = true
