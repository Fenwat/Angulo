extends Node
class_name StateMachineComponent

@export var animator_component: AnimatorComponent

## Array of all entity states. Order does not matter.
@export var entity_states: EntityStates

@onready var entity = $".."
@onready var current_entity_type = entity.entity_type

var entity_state_locked: bool = false
