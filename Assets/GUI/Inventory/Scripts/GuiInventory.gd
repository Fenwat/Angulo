extends Control
class_name GuiInventory

@export var inventory: PlayerInventory

@onready var gui_layer = $".."
@onready var skin_debug_rect = $SkinDebugRect
@onready var gui_player_inventory = $PlayerInventory

@onready var gui_inventory_break = preload("res://Assets/GUI/Inventory/Scenes/gui_sub_inventory_break.tscn")
@onready var gui_sub_inventory = preload("res://Assets/GUI/Inventory/Scenes/gui_sub_inventory.tscn")
@onready var gui_sub_inventory_text = preload("res://Assets/GUI/Inventory/Scenes/gui_sub_inventory_text.tscn")

var gui_sub_inventories_array: Array[Control]
#var is_open: bool = false

# debug switches
var debug_new_item_enabled: bool = false
var debug_inventory_contents_enabled: bool = false
var debug_skin_enabled: bool = false
var debug_gui_subinventories_enabled: bool = false

#-------------------------------------------------------------------------------------------------
#-------------------------------------------Ready-------------------------------------------------
#-------------------------------------------------------------------------------------------------

func _ready():
	_connect_signals()
	handle_skin_debug()

func _connect_signals():
	PlayerInventorySignalBus.connect("item_added_to_player_inventory", handle_new_item)

#-------------------------------------------------------------------------------------------------
#--------------------------------------Display-Inventory------------------------------------------
#-------------------------------------------------------------------------------------------------

func open_inventory():
	visible = true
	gui_layer.is_open = true

func close_inventory():
	visible = false
	gui_layer.is_open = false

#-------------------------------------------------------------------------------------------------
#----------------------------------------Gui-Sub-Inventories--------------------------------------
#-------------------------------------------------------------------------------------------------

func handle_new_item(item):
	debug_new_item(item)
	populate_gui_inventory()
	debug_inventory_contents()

func populate_gui_inventory():
	if inventory.sub_inventories.size() == 0:
		return
	
	clear_gui_inventory()
	create_gui_sub_inventory_elements()
	debug_gui_subinventories()

func create_gui_sub_inventory_elements():
	for sub_inventory_element in inventory.sub_inventories:
		append_gui_text()
		append_gui_break()
		append_gui_sub_inventory(sub_inventory_element)
		add_gui_sub_inventory_elements(sub_inventory_element)

func add_gui_sub_inventory_elements(sub_inventory_element):
	for gui_sub_inventory_element in gui_sub_inventories_array:
		if gui_sub_inventory_element.added_to_gui == false:
			gui_sub_inventory_element.sub_inventory_y_position = determine_sub_inventory_element_y_position()
			if gui_sub_inventory_element.type == 0:
				gui_sub_inventory_element.label_text = sub_inventory_element.sub_inventory_name
			gui_player_inventory.add_child(gui_sub_inventory_element)
			gui_sub_inventory_element.added_to_gui = true

#------------------------------------Clear-Children---------------------------------------

func clear_gui_inventory():
	var inventory_children = gui_player_inventory.get_children()
	
	for child in inventory_children:
		#print("Clearing child: ", child, " of type: ", child.type)
		gui_player_inventory.remove_child(child)

#-------------------------------Append-GUI-Sub-Elements-----------------------------------

func append_gui_text():
	var new_gui_sub_inventory_text = gui_sub_inventory_text.instantiate()
	gui_sub_inventories_array.append(new_gui_sub_inventory_text)

func append_gui_break():
	var new_gui_inventory_break = gui_inventory_break.instantiate()
	gui_sub_inventories_array.append(new_gui_inventory_break)

func append_gui_sub_inventory(sub_inventory_element):
		var new_gui_sub_inventory = gui_sub_inventory.instantiate()
		new_gui_sub_inventory.gui_sub_inventory_name = sub_inventory_element.sub_inventory_name
		gui_sub_inventories_array.append(new_gui_sub_inventory)

#-------------------------------Gui-Sub-Inventory-Element-Height-----------------------------------

func determine_sub_inventory_element_y_position():
	var final_y_position
	var top_buffer = 1
	var sub_inventory_heights: int = 0
	var inventory_children = gui_player_inventory.get_children()
	
	for child in inventory_children:
		sub_inventory_heights += child.height
	
	final_y_position = top_buffer + sub_inventory_heights
	return final_y_position

#----------------------------------------------------------------------------------------
#---------------------------------------Debug--------------------------------------------
#----------------------------------------------------------------------------------------

func handle_skin_debug():
	if debug_skin_enabled:
		skin_debug_rect.visible = true
	else:
		skin_debug_rect.visible = false

func debug_new_item(item):
	if debug_new_item_enabled == false:
		return
	
	print("----New item: ", item.item_name, "----")

func debug_inventory_contents():
	if debug_inventory_contents_enabled == false:
		return
	
	print("")
	print("----------------PLAYER-INVENTORY-------------------")
	for sub_inventory in inventory.sub_inventories:
		if sub_inventory.items.size() > 0:
			print_contents(sub_inventory)

func print_contents(sub_inventory):
	print(sub_inventory.sub_inventory_name + ":")
	for item in sub_inventory.items:
		print("    -" + item.item_name)

func debug_gui_subinventories():
	if debug_gui_subinventories_enabled == false:
		return
	
	var inventory_children = gui_player_inventory.get_children()
	print("-------------------------------------------------------")
	for child in inventory_children:
		print(child.sub_inventory_y_position,"-", child.type, child.layout_mode)
