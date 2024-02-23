extends Button

@onready var slot = $".."

@onready var new_item = null
@onready var button = Button.new()

func _ready():
	button.pressed.connect(self._button_pressed)
	configure_button()
	add_child(button)

func configure_button():
	button.self_modulate.a = 0

func set_item(item: PlayerInventoryItem):
	new_item = item

func _button_pressed():
	if new_item != null:
		PlayerInventorySignalBus.emit_signal("item_added_to_player_inventory", new_item)
	else:
		print("No item or function defined")
