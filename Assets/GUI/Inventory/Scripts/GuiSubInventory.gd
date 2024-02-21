extends Control
class_name GuiSubInventory

@export var inventory: PlayerInventory

@onready var grid_container = $GridContainer
@onready var slots: Array = grid_container.get_children()
@onready var slot = preload("res://Assets/GUI/Inventory/Scenes/gui_slot.tscn")

enum gui_type {TEXT, SUBINVENTORY, BREAK}

var height: int
var type = gui_type.SUBINVENTORY
var gui_sub_inventory_name: String
var added_to_gui: bool = false
var sub_inventory_y_position: int = 0

func _ready():
	set_sub_inventory_parameters()
	call_deferred("populate_slots")

func set_sub_inventory_parameters():
	var inventory_columns = set_column_count()
	set_y_position()
	set_height()
	create_grid(inventory_columns)

func set_column_count():
	var inventory_columns
	var inventory_pixel_count = 84.0 # replace 84 with reference to inventory's 'size.x'
	
	inventory_columns = (inventory_pixel_count - 4) / 10.0
	grid_container.columns = inventory_columns
	return inventory_columns

func set_y_position():
	grid_container.position.y = sub_inventory_y_position

func set_height():
	height = 9

func create_grid(columns):
	while columns > 0:
		columns -= 1
		var new_slot = slot.instantiate()
		grid_container.add_child(new_slot)
	
	slots = grid_container.get_children()


func populate_slots():
	for sub_inventory in inventory.sub_inventories:
		if sub_inventory.sub_inventory_name == gui_sub_inventory_name:
			print("Populating slots for sub-inventory: " + gui_sub_inventory_name)
			var count = min(sub_inventory.items.size(), slots.size())
			for i in range(count):
				var item = sub_inventory.items[i]
				slots[i].update(item)
				print("Updating slot: " + str(i) + " with item: " + item.item_name)

