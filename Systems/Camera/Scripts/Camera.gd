extends Node

@onready var player = $"../../../Level/Characters/Player"
@onready var bounding_box = $"../../../Level/BoundingArea/BoundingBox"
@onready var camera_2d = $"."

var smooth_speed = 10.0 # Adjust this value to change the smoothness

func _ready():
	_initialize_on_player()
	set_limits()

func _physics_process(delta):
	follow_player(delta)

func _initialize_on_player():
	var player_position = player.position
	self.position = player_position

func follow_player(delta):
	var player_position = player.position
	self.position = self.position.lerp(player_position, smooth_speed * delta)

func set_limits():
	var camera_area = Vector2(bounding_box.shape.size)
	var right_limit = camera_area.x
	var bottom_limit = camera_area.y
	
	self.limit_left = 0.0
	self.limit_top = 0.0
	self.limit_right = right_limit
	self.limit_bottom = bottom_limit
