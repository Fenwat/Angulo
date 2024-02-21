extends Control
class_name GuiSubInventoryBreak

@onready var nine_patch_rect = $NinePatchRect

enum gui_type {TEXT, SUBINVENTORY, BREAK}

var height: int = 2
var type = gui_type.BREAK
var sub_inventory_y_position: int = 0
var added_to_gui: bool = false

func _ready():
	set_break_y_position()
	set_break_size()

func set_break_size():
	nine_patch_rect.size.x = 78

func set_break_y_position():
	nine_patch_rect.position.y = sub_inventory_y_position
