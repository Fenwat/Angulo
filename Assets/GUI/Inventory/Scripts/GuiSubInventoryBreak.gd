extends Control
class_name GuiSubInventoryBreak

@onready var nine_patch_rect = $NinePatchRect

enum gui_type {TEXT, SUBINVENTORY, BREAK}

var height: int
var type = gui_type.SUBINVENTORY

func _ready():
	set_break_size()

func set_break_size():
	nine_patch_rect.size.x = 78
	nine_patch_rect.position.y = 11
	
