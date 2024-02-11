extends CanvasLayer

@onready var gui_inventory = $GuiInventory

func _ready():
	gui_inventory.close_inventory()

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if gui_inventory.isOpen:
			gui_inventory.close_inventory()
		else:
			gui_inventory.open_inventory()
