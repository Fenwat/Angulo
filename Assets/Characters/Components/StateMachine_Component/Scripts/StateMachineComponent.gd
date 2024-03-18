extends Node
class_name StateMachineComponent

@export var animator: AnimatorComponent
@export var inventory: InventoryComponent

## Array of all entity states. Order does not matter.
@export var states: Array[EntityState]

@onready var entity = $".."
@onready var current_entity_type = entity.character_type

var entity_state_locked: bool = false
