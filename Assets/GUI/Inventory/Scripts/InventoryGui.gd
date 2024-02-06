extends Control

@onready var inventory: PlayerInventory = preload("res://Assets/Characters/Player/Inventory/Resource/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var skin_debug_rect = $SkinDebugRect

var isOpen: bool = false
var skinDebugMode: bool = true

func _ready():
	handle_debug()
	update()

func handle_debug():
	if skinDebugMode:
		skin_debug_rect.visible = true
	else:
		skin_debug_rect.visible = false

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open_inventory():
	visible = true
	isOpen = true

func close_inventory():
	visible = false
	isOpen = false
