extends Resource
class_name PressInputMap

## Should be the same name as cooresponding input map in the Project Setting.
@export var press_input_name: String

## Function to be called when input is pressed.
@export var pressed_function: String

## Node where pressed_function and released_function are located.
@export_enum (
	"CHARACTER_SPRITE",
	"CHARACTER_MOVEMENT",
	"CHARACTER_STATE_MACHINE",
	"CHARACTER_ANIMATOR",
	"CHARACTER_SKIN",
	"CHARACTER_EQUIPMENT",
	"CHARACTER_INVENTORY",
	"CHARACTER_SIGNAL_EMITTER"
	) var character_nodes 
