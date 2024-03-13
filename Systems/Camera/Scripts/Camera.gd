extends Node

var player_position
var bounding_box
var smooth_speed = 30.0 # Adjust this value to change the smoothness

func _ready():
	PlayerSignalBus.connect("player_position_updated", collect_player_position)
	LevelSignalBus.connect("level_bounding_box", collect_bounding_box)
	
	call_deferred("_initialize_on_player")
	call_deferred("set_limits")

func _physics_process(delta):
	follow_player(delta)

func collect_player_position(position):
	player_position = position

func _initialize_on_player():
	self.position = player_position

func follow_player(delta):
	if !player_position:
		return
	self.position = self.position.lerp(player_position, smooth_speed * delta)

func collect_bounding_box(size):
	bounding_box = size

func set_limits():
	var right_limit = bounding_box.x
	var bottom_limit = bounding_box.y
	
	self.limit_left = 0.0
	self.limit_top = 0.0
	self.limit_right = right_limit
	self.limit_bottom = bottom_limit
