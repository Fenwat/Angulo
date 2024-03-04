extends Resource
class_name AttackStateData

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
