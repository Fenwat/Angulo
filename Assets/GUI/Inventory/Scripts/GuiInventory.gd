extends Control
class_name GuiInventory

@export var inventory: PlayerInventory
@export var gui_sub_inventories_array: Array[GuiSubInventoryElement]

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
	handle_sub_inventories()
	visible = true
	isOpen = true

func close_inventory():
	visible = false
	isOpen = false

#----------------------------------------Gui-Sub-Inventories--------------------------------------

func handle_new_item(_item):
	handle_sub_inventories()
	print_sub_inventories_array()

func handle_sub_inventories():
	for sub_inventory_element in inventory.sub_inventories:
		if !sub_inventory_element:
			var new_sub_inventory = gui_sub_inventory.instantiate()
			sub_inventory_element.gui_sub_inventory_element = new_sub_inventory

#-----------------------------------------Debug--------------------------------------------------

func handle_skin_debug():
	if skinDebugEnabled:
		skin_debug_rect.visible = true
	else:
		skin_debug_rect.visible = false

func print_sub_inventories_array():
	pass
	#print(gui_sub_inventories_array)
	#for sub_inventory in gui_sub_inventories_array:
		#if sub_inventory.items.size() > 0:
			#print(str(sub_inventory.type) + " : " + str(sub_inventory.height))
