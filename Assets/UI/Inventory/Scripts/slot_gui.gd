extends Panel

@onready var slot_sprite: Sprite2D = $SlotSprite
@onready var item_sprite: Sprite2D = $CenterContainer/Panel/ItemSprite
@onready var button = $Button

func update(item: PlayerInventoryItem):
	if !item:
		slot_sprite.frame = 0
		item_sprite.visible = false
	else:
		slot_sprite.frame = 1
		item_sprite.visible = true
		item_sprite.texture = item.item_texture
		button.set_item(item)
