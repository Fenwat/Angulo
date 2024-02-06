extends CanvasLayer

@onready var inventory_gui = $InventoryGui

func _ready():
	inventory_gui.close_inventory()

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if inventory_gui.isOpen:
			inventory_gui.close_inventory()
		else:
			inventory_gui.open_inventory()
