extends Node

signal item_equipped
const ITEM_EQUIPPED: String = "item_equipped"
func signal_item_equipped():
	emit_signal("item_equipped")
