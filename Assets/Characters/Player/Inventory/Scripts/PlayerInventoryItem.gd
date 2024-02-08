extends Resource
class_name PlayerInventoryItem

@export var item_texture: Texture2D 
@export var item_name: String = ""
@export_multiline var item_description: String = ""
@export_enum("ARMOR", "WEAPON") var item_type

