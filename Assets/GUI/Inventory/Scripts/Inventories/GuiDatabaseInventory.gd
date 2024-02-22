extends Control
class_name GuiDatabaseInventory

@export var inventory: PlayerInventory

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var gui_layer = $".."

func _ready():
	update_inventory()

func update_inventory():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open_inventory():
	visible = true
	gui_layer.is_open = true

func close_inventory():
	visible = false
	gui_layer.is_open = false
