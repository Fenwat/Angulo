extends PlayerInventoryItem

class_name ArmorItem

@export var weight: float
@export var defense: float
@export var source_rect: Vector4
@export var dest_rect: DestRect
@export_enum("HELMET", "CHESTPLATE", "LEGGINGS", "GAUNTLETS", "CAPE") var armor_type
