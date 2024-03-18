extends Node
class_name AttackStateData1

## The type of attack.
@export_enum(
	"LIGHT",
	"HEAVY"
	) var attack_type

## Enabled if attack is part of a string of attacks.
@export var part_of_string_attack: bool

## Only used if 'Part Of String Attack' is enabled.
## Indicates what specific attack string this attack state is a part of.
@export var attack_string_name: String

## Only used if 'Part Of String Attack' is enabled.
## Indicates when in the attack string this attack state is placed.
## Starts at 0.
@export var attack_index: int

## Data for north-facing attacks
@export var north_attack_data: CardinalAttackData

## Data for south-facing attacks
@export var south_attack_data: CardinalAttackData

## Data for east-facing attacks
@export var east_attack_data: CardinalAttackData

## Data for west-facing attacks
@export var west_attack_data: CardinalAttackData
