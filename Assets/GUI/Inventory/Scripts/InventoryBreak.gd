extends Control
class_name InventoryBreak

@onready var nine_patch_rect = $NinePatchRect

func _ready():
	set_break_size()

func set_break_size():
	nine_patch_rect.size.x = 78
	nine_patch_rect.position.y = 11
	
