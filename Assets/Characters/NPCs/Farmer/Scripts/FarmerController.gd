extends CharacterBody2D

@export var map: TileMap
@export var navigation_agent: NavigationAgent2D

var is_farming: bool = false

#@export var navigation_region: NavigationRegion2D

func _ready():
	navigation_agent.path_desired_distance = 1.0
	navigation_agent.target_desired_distance = 1.0

