extends Node2D
class_name EquipmentManager

@export var equipment_load: EquipmentLoad

@onready var skin_manager = $"../SkinManager"

var debug_enabled: bool = false

func _ready():
	PlayerInventorySignalBus.connect("player_inventory_button_pressed", handle_pressed_inventory_item)
	equip_equipment_load(equipment_load)

func handle_pressed_inventory_item(item):
	equip_item(item)

func equip_equipment_load(loadout):
	equip_item(loadout.helmet)
	equip_item(loadout.chestplate)
	equip_item(loadout.leggings)
	equip_item(loadout.gauntlets)
	equip_item(loadout.cape)

func equip_item(item):
	skin_manager.set_new_skin(item.source_rect, item.dest_rect.rect)
	
	if debug_enabled:
		print_item_equip_debug(item)

#----------------------------Debug------------------------------------------------

func print_item_equip_debug(item):
	print(item.item_name + " equipped")
