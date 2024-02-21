extends Control
class_name GuiInventory

@export var inventory: PlayerInventory

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var skin_debug_rect = $SkinDebugRect
@onready var gui_player_inventory = $PlayerInventory
@onready var gui_inventory_break = preload("res://Assets/GUI/Inventory/Scenes/gui_sub_inventory_break.tscn")
@onready var gui_sub_inventory = preload("res://Assets/GUI/Inventory/Scenes/gui_sub_inventory.tscn")
@onready var gui_sub_inventory_text = preload("res://Assets/GUI/Inventory/Scenes/gui_sub_inventory_text.tscn")

var gui_sub_inventories_array: Array[Control]
var isOpen: bool = false
var skinDebugEnabled: bool = false

func _ready():
	PlayerInventorySignalBus.connect("player_inventory_button_pressed", handle_new_item)
	handle_skin_debug()
	update_inventory()

func update_inventory():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open_inventory():
	populate_gui_inventory()
	visible = true
	isOpen = true

func close_inventory():
	visible = false
	isOpen = false

#----------------------------------------Gui-Sub-Inventories--------------------------------------

func handle_new_item(_item):
	populate_gui_inventory()
	debug_inventory_contents()

func populate_gui_inventory():
	if inventory.sub_inventories.size() == 0:
		print("No subinventories")
		return
	
	create_gui_sub_inventory_elements()

func create_gui_sub_inventory_elements():
	#add_gui_text()
	for sub_inventory_element in inventory.sub_inventories:
		var exists: bool = false
		
		for existing_gui_sub_inventory in gui_sub_inventories_array:
			if existing_gui_sub_inventory.type == 1:
				if existing_gui_sub_inventory.gui_sub_inventory_name == sub_inventory_element.sub_inventory_name:
					exists = true
					break
		
		if !exists:
			var new_gui_sub_inventory = gui_sub_inventory.instantiate()
			add_gui_break()
			new_gui_sub_inventory.gui_sub_inventory_name = sub_inventory_element.sub_inventory_name
			gui_sub_inventories_array.append(new_gui_sub_inventory)
			add_gui_sub_inventory_elements(sub_inventory_element)

func add_gui_sub_inventory_elements(sub_inventory_element):
	for gui_sub_inventory_element in gui_sub_inventories_array:
		if gui_sub_inventory_element.type == 0:
			if !gui_sub_inventory_element.added_to_gui:
				gui_sub_inventory_element.sub_inventory_y_position = determine_sub_inventory_element_y_position()
				gui_sub_inventory_element.label_text = sub_inventory_element.sub_inventory_name
				gui_player_inventory.add_child(gui_sub_inventory_element)
				gui_sub_inventory_element.added_to_gui = true
		else:
			if !gui_sub_inventory_element.added_to_gui:
				gui_sub_inventory_element.sub_inventory_y_position = determine_sub_inventory_element_y_position()
				gui_player_inventory.add_child(gui_sub_inventory_element)
				gui_sub_inventory_element.added_to_gui = true

func add_gui_text():
	var new_gui_sub_inventory_text = gui_sub_inventory_text.instantiate()
	gui_sub_inventories_array.append(new_gui_sub_inventory_text)

func add_gui_break():
	var new_gui_inventory_break = gui_inventory_break.instantiate()
	gui_sub_inventories_array.append(new_gui_inventory_break)

#-------------------------------Gui-Sub-Inventory-Element-Height-----------------------------------

func determine_sub_inventory_element_y_position():
	var final_y_position
	var sub_inventory_heights: int = 0
	var inventory_children = gui_player_inventory.get_children()
	
	for child in inventory_children:
		print(child.sub_inventory_y_position,"-", child.type)
		sub_inventory_heights += child.height
	
	final_y_position = sub_inventory_heights
	return final_y_position

#-----------------------------------------Debug--------------------------------------------------

func handle_skin_debug():
	if skinDebugEnabled:
		skin_debug_rect.visible = true
	else:
		skin_debug_rect.visible = false

func debug_inventory_contents():
	print("")
	print("----------------PLAYER-INVENTORY-------------------")
	for sub_inventory in inventory.sub_inventories:
		if sub_inventory.items.size() > 0:
			print_contents(sub_inventory)
			
func print_contents(sub_inventory):
	print(sub_inventory.sub_inventory_name + ":")
	for item in sub_inventory.items:
		print("    -" + item.item_name)
