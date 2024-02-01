extends Node2D

var editor_debug_mode = false
var equipment_data = {}

func _ready():
	load_equipment_data()
	if editor_debug_mode:
		print_equipment_data()
		test_get_source_rect()

func get_source_rect_for_equipment(type: String, variant_name: String = "default") -> Array:
	for group_name in equipment_data.keys():
		var group_data = equipment_data[group_name]
		for data in group_data:
			if data["type"] == type && data["variant_name"] == variant_name:
				return data["source_rect"]
	# Return an empty Array if not found
	return []

func load_equipment_data():
	equipment_data = {
	#---------------------------------Armour Sets------------------------------------------------
		"UnequippedSet": [
			{"type": "helmet", "variant_name": "unequipped_", "source_rect": [7, 40, 15, 4]},
			{"type": "chestplate", "variant_name": "unequipped_", "source_rect": [7, 44, 15, 7]},
			{"type": "gauntlets", "variant_name": "unequipped_", "source_rect": [23, 40, 6, 3]},
			{"type": "leggings", "variant_name": "unequipped_", "source_rect": [23, 44, 6, 7]},
			{"type": "cape", "variant_name": "unequipped_", "source_rect": [1, 40, 5, 11]}
		],
		"KnightSet": [
			{"type": "helmet", "variant_name": "knight_", "source_rect": [7, 14, 15, 4]},
			{"type": "chestplate", "variant_name": "knight_", "source_rect": [7, 18, 15, 7]},
			{"type": "gauntlets", "variant_name": "knight_", "source_rect": [23, 14, 6, 3]},
			{"type": "leggings", "variant_name": "knight_", "source_rect": [23, 18, 6, 7]},
			{"type": "cape", "variant_name": "knight_", "source_rect": [1, 14, 5, 11]}
		],
		"RoyalGuardSet": [
			{"type": "helmet", "variant_name": "royal_guard_", "source_rect": [37, 1, 15, 4]},
			{"type": "chestplate", "variant_name": "royal_guard_", "source_rect": [37, 5, 15, 7]},
			{"type": "gauntlets", "variant_name": "royal_guard_", "source_rect": [53, 1, 6, 3]},
			{"type": "leggings", "variant_name": "royal_guard_", "source_rect": [53, 5, 6, 7]},
			{"type": "cape", "variant_name": "royal_guard_", "source_rect": [31, 1, 5, 11]}
		],
		"ChainmailSet": [
			{"type": "helmet", "variant_name": "chainmail_", "source_rect": [67, 27, 15, 4]},
			{"type": "chestplate", "variant_name": "chainmail_", "source_rect": [67, 31, 15, 7]},
			{"type": "gauntlets", "variant_name": "chainmail_", "source_rect": [83, 27, 6, 3]},
			{"type": "leggings", "variant_name": "chainmail_", "source_rect": [83, 31, 6, 7]},
			{"type": "cape", "variant_name": "chainmail_", "source_rect": [61, 27, 5, 11]}
		],
		"SteelSet": [
			{"type": "helmet", "variant_name": "steel_", "source_rect": [7, 27, 15, 4]},
			{"type": "chestplate", "variant_name": "steel_", "source_rect": [7, 31, 15, 7]},
			{"type": "gauntlets", "variant_name": "steel_", "source_rect": [23, 27, 6, 3]},
			{"type": "leggings", "variant_name": "steel_", "source_rect": [23, 31, 6, 7]},
			{"type": "cape", "variant_name": "steel_", "source_rect": [1, 27, 5, 11]}
		],
		"BronzeSet": [
			{"type": "helmet", "variant_name": "bronze_", "source_rect": [7, 53, 15, 4]},
			{"type": "chestplate", "variant_name": "bronze_", "source_rect": [7, 57, 15, 7]},
			{"type": "gauntlets", "variant_name": "bronze_", "source_rect": [23, 53, 6, 3]},
			{"type": "leggings", "variant_name": "bronze_", "source_rect": [23, 57, 6, 7]},
			{"type": "cape", "variant_name": "bronze_", "source_rect": [1, 53, 5, 11]}
		],
	#---------------------------------Straight Swords--------------------------------------------
		"StraightSword": [
			{"type": "sword", "variant_name": "knight_", "source_rect": [93, 1, 10, 3]},
			{"type": "sword", "variant_name": "royal_guard_", "source_rect": [93, 25, 10, 3]}
		],
	#---------------------------------Spears--------------------------------------------
		"Spear": [
			{"type": "spear", "variant_name": "knight_", "source_rect": [108, 1, 16, 1]},
			{"type": "spear", "variant_name": "royal_guard_", "source_rect": [108, 21, 16, 1]}
		]
}

func print_equipment_data() -> void:
	for data in equipment_data:
		print(data + " Data:")
		for element in equipment_data[data]:
			print(element)
		print("")

func test_get_source_rect():
	var type = "helmet"
	var variant_name = "knight_"

	var source_rect = get_source_rect_for_equipment(type, variant_name)

	if source_rect.size() > 0:
		print("Source Rect for " + variant_name + type + ": " + str(source_rect))
	else:
		print("Equipment not found.")
