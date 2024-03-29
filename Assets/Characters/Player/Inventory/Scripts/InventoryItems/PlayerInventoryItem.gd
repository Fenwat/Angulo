extends Resource
class_name PlayerInventoryItem

@export var item_texture: Texture2D 
@export var item_name: String = ""
@export_multiline var item_description: String = ""
@export_enum("ARMOR", "WEAPON") var item_type
@export var inventory_item_priority: int

@export var sub_inventory_data: SubInventoryData
