extends Resource
class_name CharacterInputMap

## Name of input map.
@export var input_map_name: String

## Tells CharacterInput class which export to use.
@export_enum(
	"DIRECTIONAL",
	"PRESS",
	"HOLD"
	) var input_map_type

## Only used if Input Map Type is of type DIRECTIONAL.
@export var directional_inputs: DirectionalInputMap

## Only used if Input Map Type is of type PRESS.
@export var press_input: PressInputMap

## Only used if Input Map Type is of type HOLD.
@export var hold_input: HoldInputMap
