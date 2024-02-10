extends Resource
class_name PlayerSubInventory

@export_enum(
	"HELMET",
	"CHESTPLATE",
	"LEGGINGS",
	"GAUNTLETS",
	"CAPE"
	) var sub_inventory_type
@export var sub_inventory_name: String
@export var items: Array[PlayerInventoryItem]
@export var sub_inventory_priority: int
