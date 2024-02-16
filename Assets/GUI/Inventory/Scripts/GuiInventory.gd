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
	print_sub_inventories_array()

func populate_gui_inventory():
	if inventory.sub_inventories.size() == 0:
		#print("No subinventories")
		return
	for sub_inventory in inventory.sub_inventories:
		if sub_inventory.items.size() == 0:
			return
		#print("New subinventory")

#func handle_sub_inventories():
	#for sub_inventory_element in inventory.sub_inventories:
		#if sub_inventory_element: 
			#if sub_inventory_element.type != 1: # 1 is SUBINVENTORY
				#return
		#
		#if sub_inventory_element.items.size() > 0:
			#print("instantiating new sub-inventory")
			#var new_gui_sub_inventory = gui_sub_inventory.instantiate()
			#new_gui_sub_inventory.gui_sub_inventory_name = sub_inventory_element.sub_inventory_name
			#print("New sub-inventory: " + new_gui_sub_inventory.gui_sub_inventory_name)

#-----------------------------------------Debug--------------------------------------------------

func handle_skin_debug():
	if skinDebugEnabled:
		skin_debug_rect.visible = true
	else:
		skin_debug_rect.visible = false

func print_sub_inventories_array():
	#print(gui_sub_inventories_array)
	for sub_inventory in gui_sub_inventories_array:
		if sub_inventory.items.size() > 0:
			print(str(sub_inventory.type) + " : " + str(sub_inventory.height))

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
