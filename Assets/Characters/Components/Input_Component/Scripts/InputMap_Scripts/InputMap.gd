extends Resource
class_name InputMap1

## Name of input map.
@export var input_map_name: String

## Tells CharacterInput class which export to use.
@export_enum(
	"DIRECTIONAL",
	"PRESS",
	"HOLD"
	) var input_map_type

## Only used if Input Map Type is of type DIRECTIONAL.
@export var directional_inputs: DirectionalInput

## Only used if Input Map Type is of type PRESS.
@export var press_input: PressInput

## Only used if Input Map Type is of type HOLD.
@export var hold_input: HoldInput
