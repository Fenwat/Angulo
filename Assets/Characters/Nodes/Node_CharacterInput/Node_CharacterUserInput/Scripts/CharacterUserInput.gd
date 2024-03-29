extends CharacterInput
class_name CharacterUserInput

@export var character_sprite: CharacterSprite
@export var character_state_machine: CharacterStateMachine
@export var character_movement: CharacterMovement
@export var character_animator: CharacterAnimator
@export var character_skin: CharacterSkin
@export var character_equipment: CharacterEquipment
@export var character_inventory: CharacterInventory
@export var character_signal_emitter: CharacterSignalEmitter

@export var character_inputs: Array[CharacterInputMap]

# CharacterState storage arrays 
var directional_input: CharacterInputMap
var press_inputs: Array[CharacterInputMap]
var hold_inputs: Array[CharacterInputMap]

enum input_map_type {
	DIRECTIONAL,
	PRESS,
	HOLD
	}

enum character_node_bank {
	CHARACTER_SPRITE,
	CHARACTER_MOVEMENT,
	CHARACTER_STATE_MACHINE,
	CHARACTER_ANIMATOR,
	CHARACTER_SKIN,
	CHARACTER_EQUIPMENT,
	CHARACTER_INVENTORY,
	CHARACTER_SIGNAL_EMITTER
	}

#----------------------------------------------------------------------------------------
#-----------------------------------------Ready------------------------------------------
#----------------------------------------------------------------------------------------

func _ready():
	_assign_character_inputs()

func _assign_character_inputs():
	for input_map in character_inputs:
		if input_map.input_map_type == input_map_type.DIRECTIONAL:
			directional_input = input_map
		elif input_map.input_map_type == input_map_type.PRESS:
			press_inputs.append(input_map)
		elif input_map.input_map_type == input_map_type.HOLD:
			hold_inputs.append(input_map)

#----------------------------------------------------------------------------------------
#----------------------------------Physics-Process---------------------------------------
#----------------------------------------------------------------------------------------

func _physics_process(_delta):
	_get_input_direction(directional_input)
	_check_hold_inputs()
	_check_press_inputs()
	_get_last_non_zero_input()

func _get_last_non_zero_input():
	if input_direction != Vector2.ZERO:
		last_non_zero_input = input_direction

func _get_input_direction(input_map: CharacterInputMap):
	var left_input: String
	var right_input: String
	var up_input: String
	var down_input: String
	
	if not input_map: return
	
	left_input = input_map.directional_inputs.left_input
	right_input = input_map.directional_inputs.right_input
	up_input = input_map.directional_inputs.up_input
	down_input = input_map.directional_inputs.down_input
	
	input_direction = Input.get_vector(left_input, right_input, up_input, down_input)

#-------------------------------------Hold-Input----------------------------------------

func _check_hold_inputs():
	if hold_inputs.size() == 0: return
		
	for hold_input in hold_inputs:
		_handle_hold_input(hold_input)

func _handle_hold_input(input: CharacterInputMap):
	var hold_input_name: String = input.hold_input.hold_input_name
	var press_function: String = input.hold_input.pressed_function
	var release_function: String = input.hold_input.released_funcion
	var function_node_location
	
	function_node_location = _determine_function_node_location(input)
	
	if Input.is_action_pressed(hold_input_name):
		function_node_location.call(press_function)
	
	if Input.is_action_just_released(hold_input_name):
		function_node_location.call(release_function)

func _determine_function_node_location(input: CharacterInputMap):
	if input.hold_input.character_nodes == character_node_bank.CHARACTER_SPRITE:
		return character_sprite
	elif input.hold_input.character_nodes == character_node_bank.CHARACTER_MOVEMENT:
		return character_movement
	elif input.hold_input.character_nodes == character_node_bank.CHARACTER_STATE_MACHINE:
		return character_state_machine
	elif input.hold_input.character_nodes == character_node_bank.CHARACTER_ANIMATOR:
		return character_animator
	elif input.hold_input.character_nodes == character_node_bank.CHARACTER_SKIN:
		return character_skin
	elif input.hold_input.character_nodes == character_node_bank.CHARACTER_EQUIPMENT:
		return character_equipment
	elif input.hold_input.character_nodes == character_node_bank.CHARACTER_INVENTORY:
		return character_inventory
	elif input.hold_input.character_nodes == character_node_bank.CHARACTER_SIGNAL_EMITTER:
		return character_signal_emitter

#-------------------------------------Press-Input-------------------------------------------

func _check_press_inputs():
	if press_inputs.size() == 0: return
		
	for press_input in press_inputs:
		_handle_press_input(press_input)

func _handle_press_input(input: CharacterInputMap):
	var press_input_name: String = input.press_input.press_input_name
	var press_function: String = input.press_input.pressed_function
	var function_node_location
	
	function_node_location = _determine_function_press_node_location(input)
	
	if Input.is_action_just_pressed(press_input_name):
		function_node_location.call(press_function)

func _determine_function_press_node_location(input: CharacterInputMap):
	if input.press_input.character_nodes == character_node_bank.CHARACTER_SPRITE:
		return character_sprite
	elif input.press_input.character_nodes == character_node_bank.CHARACTER_MOVEMENT:
		return character_movement
	elif input.press_input.character_nodes == character_node_bank.CHARACTER_STATE_MACHINE:
		return character_state_machine
	elif input.press_input.character_nodes == character_node_bank.CHARACTER_ANIMATOR:
		return character_animator
	elif input.press_input.character_nodes == character_node_bank.CHARACTER_SKIN:
		return character_skin
	elif input.press_input.character_nodes == character_node_bank.CHARACTER_EQUIPMENT:
		return character_equipment
	elif input.press_input.character_nodes == character_node_bank.CHARACTER_INVENTORY:
		return character_inventory
	elif input.press_input.character_nodes == character_node_bank.CHARACTER_SIGNAL_EMITTER:
		return character_signal_emitter
