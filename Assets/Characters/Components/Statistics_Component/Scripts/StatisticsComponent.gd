extends Node
class_name StatisticsComponent

# maximum statistic values. adjusted as entity increases level
var max_health: float
var max_stamina: float

# current statistic values. adjusted as through gameplay
var current_health: float
var current_stamina: float

func _ready():
	_set_max_values()
	_set_current_values()

func _set_max_values():
	if max_health == null:
		max_health = 100.0
	if max_stamina == null:
		max_stamina = 50.0

func _set_current_values():
	if current_health == null:
		current_health = max_health
	if current_stamina == null:
		current_stamina = max_stamina
