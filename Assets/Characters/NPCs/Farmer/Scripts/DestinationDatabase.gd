extends Node2D

var destination_data = {}

func _ready():
	load_destination_data()

func select_destination(destination_name: String):
	for destination in destination_data["destinations"]:
		if destination["destination_name"] == destination_name:
			# Convert the coordinate list to Vector2
			var coordinate_vector = Vector2(destination["coordinate"][0], destination["coordinate"][1])
			# If a match is found, return the 'level' and the converted 'coordinate' as Vector2
			return coordinate_vector
	return {}

func load_destination_data():
	destination_data = {
		"destinations": [
			{"destination_name": "field", "level": "level_1", "coordinate": [41, 28]},
			{"destination_name": "farm_house", "level": "level_1", "coordinate": [78, 16]}
		]
	}
