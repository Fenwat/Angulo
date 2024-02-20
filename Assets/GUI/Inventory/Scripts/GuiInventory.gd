extends Control
class_name GuiInventory

@export var inventory: PlayerInventory
@export var gui_sub_inventories_array: Array[Control]

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var skin_debug_rect = $SkinDebugRect
@onready var gui_inventory_break = preload("res://Assets/GUI/Inventory/Scenes/gui_sub_inventory_break.tscn")
@onready var gui_sub_inventory = preload("res://Assets/GUI/Inventory/Scenes/gui_sub_inventory.tscn")
@onready var gui_player_inventory = $PlayerInventory

var isOpen: bool = false
var skinDebugEnabled: bool = true

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
	#print_sub_inventories_array()

func populate_gui_inventory():
	if inventory.sub_inventories.size() == 0:
		print("No subinventories")
		return
	
	create_gui_sub_inventory_elements()

func create_gui_sub_inventory_elements():
	for sub_inventory_element in inventory.sub_inventories:
		var exists: bool = false
		
		for existing_gui_sub_inventory in gui_sub_inventories_array:
			if existing_gui_sub_inventory.gui_sub_inventory_name == sub_inventory_element.sub_inventory_name:
				exists = true
				break
		
		if !exists:
			var new_gui_sub_inventory = gui_sub_inventory.instantiate()
			new_gui_sub_inventory.gui_sub_inventory_name = sub_inventory_element.sub_inventory_name
			gui_sub_inventories_array.append(new_gui_sub_inventory)
			add_gui_sub_inventory_elements()

func add_gui_sub_inventory_elements():
	for gui_sub_inventory_element in gui_sub_inventories_array:
		if !gui_sub_inventory_element.added_to_gui:
			add_gui_break()
			gui_sub_inventory_element.sub_inventory_y_position = determine_sub_inventory_element_y_position()
			gui_player_inventory.add_child(gui_sub_inventory_element)
			gui_sub_inventory_element.added_to_gui = true

func add_gui_break():
	var new_gui_inventory_break = gui_sub_inventory.instantiate()
	gui_player_inventory.add_child(new_gui_inventory_break)

#-------------------------------Gui-Sub-Inventory-Element-Height-----------------------------------

func determine_sub_inventory_element_y_position():
	var final_y_position
	const top_buffer: int = 2
	var text_buffer: int = 8
	var inventory_break_height: int = 2
	var sub_inventory_heights: int = 0
	
	var array1 = gui_player_inventory.get_children()
	
	for item in array1:
		if item != gui_sub_inventory:
			break
		if item.type == 1:
			sub_inventory_heights += item.sub_inventory_y_position
	
	final_y_position = top_buffer + text_buffer + inventory_break_height + sub_inventory_heights
	return final_y_position

#-----------------------------------------Debug--------------------------------------------------

func handle_skin_debug():
	if skinDebugEnabled:
		skin_debug_rect.visible = true
	else:
		skin_debug_rect.visible = false

func print_sub_inventories_array():
	for sub_inventory in gui_sub_inventories_array:
		print(sub_inventory)
		#if sub_inventory.items.size() > 0:
			#print(str(sub_inventory.type) + " : " + str(sub_inventory.height))

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
