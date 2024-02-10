extends Node

@export var inventory: PlayerInventory

func _ready():
	PlayerInventorySignalBus.connect("player_inventory_button_pressed", add_item_to_inventory)

func add_item_to_inventory(item):
	var sub_inventory = inventory.sub_inventories[item.armor_type]
	var index = item.inventory_item_priority
	var item_added = false
	
	for i in range(sub_inventory.items.size()):
		if sub_inventory.items[i].inventory_item_priority > index:
			sub_inventory.items.insert(i, item)
			item_added = true
			break
	
	if not item_added:
		sub_inventory.items.append(item)
	
	debug_inventory_contents()

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
