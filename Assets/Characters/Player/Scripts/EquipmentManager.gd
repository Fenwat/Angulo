extends Node2D
class_name EquipmentManager

@onready var equipment_database = $"EquipmentDatabase"
@onready var skin_manager = $"../SkinManager"

var source_rect = []

func _ready():
	Signals.connect("item_equipped", Callable(self, "_call_function_by_name"))
	unequip_armor()

func _call_function_by_name():
	call(GlobalVariables.set_equip_function)
	GlobalVariables.set_equip_function = ""

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
func equip_knight_armor():
	equip_knight_helmet()
	equip_knight_chestplate()
	equip_knight_gauntlets()
	equip_knight_leggings()
	equip_knight_cape()

func equip_knight_helmet():
	source_rect = equipment_database.get_source_rect_for_equipment("helmet", "knight_")
	skin_manager.set_new_skin(Enums.EquipmentType.HELMET, source_rect)

func equip_knight_chestplate():
	source_rect = equipment_database.get_source_rect_for_equipment("chestplate", "knight_")
	skin_manager.set_new_skin(Enums.EquipmentType.CHESTPLATE, source_rect)

func equip_knight_gauntlets():
	source_rect = equipment_database.get_source_rect_for_equipment("gauntlets", "knight_")
	skin_manager.set_new_skin(Enums.EquipmentType.GAUNTLETS, source_rect)

func equip_knight_leggings():
	source_rect = equipment_database.get_source_rect_for_equipment("leggings", "knight_")
	skin_manager.set_new_skin(Enums.EquipmentType.LEGGINGS, source_rect)

func equip_knight_cape():
	source_rect = equipment_database.get_source_rect_for_equipment("cape", "knight_")
	skin_manager.set_new_skin(Enums.EquipmentType.CAPE, source_rect)

#----------------------------Royal Guard's Set----------------------------------

func equip_royal_guard_armor():
	equip_royal_guard_helmet()
	equip_royal_guard_chestplate()
	equip_royal_guard_gauntlets()
	equip_royal_guard_leggings()
	equip_royal_guard_cape()

func equip_royal_guard_helmet():
	source_rect = equipment_database.get_source_rect_for_equipment("helmet", "royal_guard_")
	skin_manager.set_new_skin(Enums.EquipmentType.HELMET, source_rect)

func equip_royal_guard_chestplate():
	source_rect = equipment_database.get_source_rect_for_equipment("chestplate", "royal_guard_")
	skin_manager.set_new_skin(Enums.EquipmentType.CHESTPLATE, source_rect)

func equip_royal_guard_gauntlets():
	source_rect = equipment_database.get_source_rect_for_equipment("gauntlets", "royal_guard_")
	skin_manager.set_new_skin(Enums.EquipmentType.GAUNTLETS, source_rect)

func equip_royal_guard_leggings():
	source_rect = equipment_database.get_source_rect_for_equipment("leggings", "royal_guard_")
	skin_manager.set_new_skin(Enums.EquipmentType.LEGGINGS, source_rect)

func equip_royal_guard_cape():
	source_rect = equipment_database.get_source_rect_for_equipment("cape", "royal_guard_")
	skin_manager.set_new_skin(Enums.EquipmentType.CAPE, source_rect)

#------------------------------Chainmail Set------------------------------------

func equip_chainmail_armor():
	equip_chainmail_helmet()
	equip_chainmail_chestplate()
	equip_chainmail_gauntlets()
	equip_chainmail_leggings()
	equip_chainmail_cape()

func equip_chainmail_helmet():
	source_rect = equipment_database.get_source_rect_for_equipment("helmet", "chainmail_")
	skin_manager.set_new_skin(Enums.EquipmentType.HELMET, source_rect)

func equip_chainmail_chestplate():
	source_rect = equipment_database.get_source_rect_for_equipment("chestplate", "chainmail_")
	skin_manager.set_new_skin(Enums.EquipmentType.CHESTPLATE, source_rect)

func equip_chainmail_gauntlets():
	source_rect = equipment_database.get_source_rect_for_equipment("gauntlets", "chainmail_")
	skin_manager.set_new_skin(Enums.EquipmentType.GAUNTLETS, source_rect)

func equip_chainmail_leggings():
	source_rect = equipment_database.get_source_rect_for_equipment("leggings", "chainmail_")
	skin_manager.set_new_skin(Enums.EquipmentType.LEGGINGS, source_rect)

func equip_chainmail_cape():
	source_rect = equipment_database.get_source_rect_for_equipment("cape", "chainmail_")
	skin_manager.set_new_skin(Enums.EquipmentType.CAPE, source_rect)

#--------------------------------Steel Set---------------------------------------

func equip_steel_armor():
	equip_steel_helmet()
	equip_steel_chestplate()
	equip_steel_gauntlets()
	equip_steel_leggings()
	equip_steel_cape()

func equip_steel_helmet():
	source_rect = equipment_database.get_source_rect_for_equipment("helmet", "steel_")
	skin_manager.set_new_skin(Enums.EquipmentType.HELMET, source_rect)

func equip_steel_chestplate():
	source_rect = equipment_database.get_source_rect_for_equipment("chestplate", "steel_")
	skin_manager.set_new_skin(Enums.EquipmentType.CHESTPLATE, source_rect)

func equip_steel_gauntlets():
	source_rect = equipment_database.get_source_rect_for_equipment("gauntlets", "steel_")
	skin_manager.set_new_skin(Enums.EquipmentType.GAUNTLETS, source_rect)

func equip_steel_leggings():
	source_rect = equipment_database.get_source_rect_for_equipment("leggings", "steel_")
	skin_manager.set_new_skin(Enums.EquipmentType.LEGGINGS, source_rect)

func equip_steel_cape():
	source_rect = equipment_database.get_source_rect_for_equipment("cape", "steel_")
	skin_manager.set_new_skin(Enums.EquipmentType.CAPE, source_rect)

#--------------------------------Steel Set---------------------------------------

func equip_bronze_armor():
	equip_bronze_helmet()
	equip_bronze_chestplate()
	equip_bronze_gauntlets()
	equip_bronze_leggings()
	equip_bronze_cape()

func equip_bronze_helmet():
	source_rect = equipment_database.get_source_rect_for_equipment("helmet", "bronze_")
	skin_manager.set_new_skin(Enums.EquipmentType.HELMET, source_rect)

func equip_bronze_chestplate():
	source_rect = equipment_database.get_source_rect_for_equipment("chestplate", "bronze_")
	skin_manager.set_new_skin(Enums.EquipmentType.CHESTPLATE, source_rect)

func equip_bronze_gauntlets():
	source_rect = equipment_database.get_source_rect_for_equipment("gauntlets", "bronze_")
	skin_manager.set_new_skin(Enums.EquipmentType.GAUNTLETS, source_rect)

func equip_bronze_leggings():
	source_rect = equipment_database.get_source_rect_for_equipment("leggings", "bronze_")
	skin_manager.set_new_skin(Enums.EquipmentType.LEGGINGS, source_rect)

func equip_bronze_cape():
	source_rect = equipment_database.get_source_rect_for_equipment("cape", "bronze_")
	skin_manager.set_new_skin(Enums.EquipmentType.CAPE, source_rect)
