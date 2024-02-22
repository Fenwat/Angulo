extends Button

@onready var slot = $".."
@onready var button = Button.new()

@onready var new_item = null

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
		PlayerInventorySignalBus.emit_signal("player_inventory_button_pressed", new_item)
	else:
		print("No item or function defined")
