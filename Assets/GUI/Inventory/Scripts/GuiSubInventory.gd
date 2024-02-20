extends Control
class_name GuiSubInventory

@export var inventory: PlayerInventory

@onready var grid_container = $GridContainer
@onready var slot = preload("res://Assets/GUI/Inventory/Scenes/gui_slot.tscn")

enum gui_type {TEXT, SUBINVENTORY, BREAK}

var height: int
var type = gui_type.SUBINVENTORY
var gui_sub_inventory_name: String
var added_to_gui: bool = false
var sub_inventory_y_position: int

func _ready():
	set_sub_inventory_parameters()

func set_sub_inventory_parameters():
	var inventory_columns = set_column_count()
	set_y_height()
	create_grid(inventory_columns)

func set_column_count():
	var inventory_columns
	var inventory_pixel_count = 84.0 # replace 84 with reference to inventory's 'size.x'
	
	inventory_columns = (inventory_pixel_count - 4) / 10.0
	grid_container.columns = inventory_columns
	return inventory_columns

func set_y_height():
	grid_container.position.y = sub_inventory_y_position

func create_grid(columns):
	while columns > 0:
		columns -= 1
		var new_slot = slot.instantiate()
		grid_container.add_child(new_slot)

func populate_grid(columns):
	# Assume inventory is already populated with sub_inventories and their items
	for sub_inventory in inventory.sub_inventories:
		if sub_inventory.items.size() > 0:
			for item in sub_inventory.items:
				if columns > 0:
					columns -= 1
					var new_slot = slot.instance()  # Instantiate a new slot
					# Assuming the slot scene has a Label node for the item name
					var item_name_label = new_slot.get_node("ItemNameLabel")
					item_name_label.text = item.item_name
					# Add the new slot to the GridContainer
					grid_container.add_child(new_slot)
				else:
					break  # Exit the loop if there are no more columns left to populate

