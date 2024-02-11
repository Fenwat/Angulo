extends Control
class_name GuiSubInventory

@export var inventory: PlayerInventory

@onready var grid_container = $GridContainer
@onready var slot = preload("res://Assets/GUI/Inventory/Scenes/gui_slot.tscn")

func _ready():
	set_sub_inventory_parameters()

func set_sub_inventory_parameters():
	var inventory_columns = set_column_count()
	set_y_height()
	populate_grid(inventory_columns)

func set_column_count():
	var inventory_columns
	var inventory_pixel_count = 84.0 # replace 84 with reference to inventory's 'size.x'
	
	inventory_columns = (inventory_pixel_count - 4) / 10.0
	grid_container.columns = inventory_columns
	return inventory_columns

func set_y_height():
	var sub_inventory_y_position = 13
	grid_container.position.y = sub_inventory_y_position

func populate_grid(columns):
	while columns > 0:
		columns -= 1
		var new_slot = slot.instantiate()
		grid_container.add_child(new_slot)
