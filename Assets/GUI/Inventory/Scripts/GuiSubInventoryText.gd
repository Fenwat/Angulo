extends Control
class_name GuiSubInventoryText

@onready var label = $Panel/Label

enum gui_type {TEXT, SUBINVENTORY, BREAK}

var height: int = 10
var type = gui_type.TEXT
var sub_inventory_y_position: int = 0
var added_to_gui: bool = false
var label_text: String

func _ready():
	set_text()
	set_text_y_position()

func set_text():
	label.text = label_text

func set_text_y_position():
	self.position.y = sub_inventory_y_position
