extends Control
class_name GuiItemDatabase

@export var database: ItemDatabase

@onready var armor_items = database.armor_items
@onready var weapons_items = database.weapon_items

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var gui_layer = $".."

func _ready():
	update_items()

func update_items():
	update_armor_items()

func update_armor_items():
	for i in range(min(armor_items.size(), slots.size())):
		slots[i].update(armor_items[i])

func open_item_database():
	visible = true
	gui_layer.item_database_is_open = true

func close_item_database():
	visible = false
	gui_layer.item_database_is_open = false
