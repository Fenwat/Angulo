extends CanvasLayer

@onready var gui_inventory = $GuiInventory
@onready var gui_database_inventory = $GuiItemDatabase

var inventory_is_open: bool = false
var item_database_is_open: bool = false

func _ready():
	gui_inventory.close_inventory()

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		_toggle_inventory()
	
	if event.is_action_pressed("toggle_item_database"):
		_toggle_item_database()

#------------------------------Main-Inventory------------------------------------

func _toggle_inventory():
	if inventory_is_open:
		close_inventories()
	else:
		open_inventories()
	PlayerInventorySignalBus.emit_signal("player_menu_toggled")

func close_inventories():
	gui_inventory.close_inventory()
	gui_database_inventory.close_item_database()

func open_inventories():
	gui_inventory.open_inventory()

#----------------------------Item-Database----------------------------------------

func _toggle_item_database():
	if inventory_is_open == false:
		return
	
	if item_database_is_open:
		gui_database_inventory.close_item_database()
	else:
		gui_database_inventory.open_item_database()
