extends Node

@export var inventory: PlayerInventory

@onready var player_sub_inventory = preload("res://Assets/Characters/Player/Inventory/Resource/SubInventories/empty_subinventory.tres")

func _ready():
	PlayerInventorySignalBus.connect("item_added_to_player_inventory", handle_new_item)

func handle_new_item(item):
	var new_sub_inventory_index = item.sub_inventory_data.sub_inventory_index
	var sub_inventory_already_added: bool = false

	for i in range(inventory.sub_inventories.size()):
		if inventory.sub_inventories[i].sub_inventory_index == new_sub_inventory_index:
			var existing_sub_inventory = inventory.sub_inventories[i]
			
			sub_inventory_already_added = true
			add_item_to_inventory(item, existing_sub_inventory)
			break
	
	if not sub_inventory_already_added:
		var new_sub_inventory = player_sub_inventory.duplicate(true)

		new_sub_inventory.sub_inventory_name = item.sub_inventory_data.sub_inventory_name
		new_sub_inventory.sub_inventory_index = item.sub_inventory_data.sub_inventory_index

		inventory.sub_inventories.append(new_sub_inventory)

		add_item_to_inventory(item, new_sub_inventory)

		
func add_item_to_inventory(item, sub_inventory):
	var index = item.inventory_item_priority
	var item_added: bool = false
	
	for i in range(sub_inventory.items.size()):
		if sub_inventory.items[i].inventory_item_priority > index:
			sub_inventory.items.insert(i, item)
			item_added = true
			break
	
	if not item_added:
		sub_inventory.items.append(item)
	

#-----------------------------------Debug--------------------------------------------------

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
