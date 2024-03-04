extends Resource
class_name CharacterState

## This should be the name used for the animation's BlendSpace2D in the AnimationTree.
@export var character_state_name: String  

# Needs to be identical to the enum in the CharacterStateMachine class. Order matters.
## Used to set the catagory the character state falls under.
@export_enum(
	"IDLE",
	"IDLE_INSERT",
	"MOVEMENT",
	"ATTACK"
	) var character_state_type

## If enabled this will lock the character in this state until the animation is finished playing.
@export var locks_character_state: bool

## If enabled, Vector2 will be set to the last non-zero input.
@export var is_static: bool

## Only used if Character State Type is set to ATTACK
@export var attack_data: AttackStateData
