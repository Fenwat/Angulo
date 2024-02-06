extends Button

@onready var new_item = null
@onready var button = Button.new()

func _ready():
	button.pressed.connect(self._button_pressed)
	add_child(button)

func set_item(item: PlayerInventoryItem):
	new_item = item

func _button_pressed():
	if new_item != null and new_item.function != "":
		GlobalVariables.set_equip_function = new_item.function
		Signals.signal_item_equipped()
	else:
		print("No item or function defined")
