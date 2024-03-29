extends Panel
class_name GuiSlot

@onready var slot_sprite: Sprite2D = $SlotSprite
@onready var item_sprite: Sprite2D = $CenterContainer/Panel/ItemSprite
@onready var button = $Button

var slot_item: PlayerInventoryItem

func _ready():
	self.self_modulate.a = 0

func update(item: PlayerInventoryItem):
	slot_item = item
	if !item:
		slot_sprite.frame = 0
		item_sprite.visible = false
	else:
		slot_sprite.frame = 1
		item_sprite.visible = true
		item_sprite.texture = item.item_texture
		button.set_item(item)

func reset_slot():
	update(slot_item)
