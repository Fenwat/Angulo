extends CanvasLayer

@onready var gui_inventory = $GuiInventory
@onready var gui_database_inventory = $GuiDatabaseInventory

var is_open: bool = false

func _ready():
	gui_inventory.close_inventory()

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if is_open:
			close_inventories()
		else:
			open_inventories()

func close_inventories():
	gui_inventory.close_inventory()
	gui_database_inventory.close_inventory()

func open_inventories():
	gui_inventory.open_inventory()
	gui_database_inventory.open_inventory()
