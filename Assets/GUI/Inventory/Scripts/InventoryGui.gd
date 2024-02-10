extends Control

@export var inventory: PlayerInventory

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var skin_debug_rect = $SkinDebugRect

var isOpen: bool = false
var skinDebugEnabled: bool = true

func _ready():
	handle_debug()
	update_inventory()

func update_inventory():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open_inventory():
	visible = true
	isOpen = true

func close_inventory():
	visible = false
	isOpen = false

#-----------------------------------------Debug--------------------------------------------------

func handle_debug():
	if skinDebugEnabled:
		skin_debug_rect.visible = true
	else:
		skin_debug_rect.visible = false
