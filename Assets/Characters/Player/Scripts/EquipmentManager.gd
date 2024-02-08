extends Node2D
class_name EquipmentManager

@onready var equipment_database = $"EquipmentDatabase"
@onready var skin_manager = $"../SkinManager"

var source_rect = []

func _ready():
	PlayerInventorySignalBus.connect("player_inventory_button_pressed", handle_pressed_inventory_item)
	unequip_armor()

func handle_pressed_inventory_item(item):
	call(item.function, item.source_rect)

#-----------------------------Unequipped Set------------------------------------

func unequip_armor():
	unequip_cape()
	unequip_helmet()
	unequip_chestplate()
	unequip_gauntlets()
	unequip_leggings()

func unequip_helmet():
	source_rect = equipment_database.get_source_rect_for_equipment("helmet", "unequipped_")
	skin_manager.set_new_skin(Enums.EquipmentType.HELMET, source_rect)

func unequip_chestplate():
	source_rect = equipment_database.get_source_rect_for_equipment("chestplate", "unequipped_")
	skin_manager.set_new_skin(Enums.EquipmentType.CHESTPLATE, source_rect)

func unequip_gauntlets():
	source_rect = equipment_database.get_source_rect_for_equipment("gauntlets", "unequipped_")
	skin_manager.set_new_skin(Enums.EquipmentType.GAUNTLETS, source_rect)

func unequip_leggings():
	source_rect = equipment_database.get_source_rect_for_equipment("leggings", "unequipped_")
	skin_manager.set_new_skin(Enums.EquipmentType.LEGGINGS, source_rect)

func unequip_cape():
	source_rect = equipment_database.get_source_rect_for_equipment("cape", "unequipped_")
	skin_manager.set_new_skin(Enums.EquipmentType.CAPE, source_rect)

#----------------------------Knight's Set---------------------------------------
#func equip_knight_armor():
	#equip_knight_helmet()
	#equip_knight_chestplate()
	#equip_knight_gauntlets()
	#equip_knight_leggings()
	#equip_knight_cape()

func equip_knight_helmet(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.HELMET, rect)

func equip_knight_chestplate(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.CHESTPLATE, rect)

func equip_knight_gauntlets(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.GAUNTLETS, rect)

func equip_knight_leggings(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.LEGGINGS, rect)

func equip_knight_cape(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.CAPE, rect)

#----------------------------Royal Guard's Set----------------------------------

#func equip_royal_guard_armor():
	#equip_royal_guard_helmet()
	#equip_royal_guard_chestplate()
	#equip_royal_guard_gauntlets()
	#equip_royal_guard_leggings()
	#equip_royal_guard_cape()

func equip_royal_guard_helmet(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.HELMET, rect)

func equip_royal_guard_chestplate(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.CHESTPLATE, rect)

func equip_royal_guard_gauntlets(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.GAUNTLETS, rect)

func equip_royal_guard_leggings(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.LEGGINGS, rect)

func equip_royal_guard_cape(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.CAPE, rect)

#------------------------------Chainmail Set------------------------------------

#func equip_chainmail_armor():
	#equip_chainmail_helmet()
	#equip_chainmail_chestplate()
	#equip_chainmail_gauntlets()
	#equip_chainmail_leggings()
	#equip_chainmail_cape()

func equip_chainmail_helmet(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.HELMET, rect)

func equip_chainmail_chestplate(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.CHESTPLATE, rect)

func equip_chainmail_gauntlets(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.GAUNTLETS, rect)

func equip_chainmail_leggings(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.LEGGINGS, rect)

func equip_chainmail_cape(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.CAPE, rect)

#--------------------------------Steel Set---------------------------------------

#func equip_steel_armor():
	#equip_steel_helmet()
	#equip_steel_chestplate()
	#equip_steel_gauntlets()
	#equip_steel_leggings()
	#equip_steel_cape()

func equip_steel_helmet(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.HELMET, rect)

func equip_steel_chestplate(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.CHESTPLATE, rect)

func equip_steel_gauntlets(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.GAUNTLETS, rect)

func equip_steel_leggings(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.LEGGINGS, rect)

func equip_steel_cape(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.CAPE, rect)

#--------------------------------Steel Set---------------------------------------

#func equip_bronze_armor():
	#equip_bronze_helmet()
	#equip_bronze_chestplate()
	#equip_bronze_gauntlets()
	#equip_bronze_leggings()
	#equip_bronze_cape()

func equip_bronze_helmet(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.HELMET, rect)

func equip_bronze_chestplate(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.CHESTPLATE, rect)

func equip_bronze_gauntlets(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.GAUNTLETS, rect)

func equip_bronze_leggings(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.LEGGINGS, rect)

func equip_bronze_cape(rect):
	skin_manager.set_new_skin(Enums.EquipmentType.CAPE, rect)
