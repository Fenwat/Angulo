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

## Indicates haw many pixels foward the character steps during the attack.
@export var attack_step_size_north: int

## Indicates haw many pixels foward the character steps during the attack.
@export var attack_step_size_east: int

## Indicates haw many pixels foward the character steps during the attack.
@export var attack_step_size_south: int

## Indicates haw many pixels foward the character steps during the attack.
@export var attack_step_size_west: int

@export var north_hitbox_position: Vector2
@export var north_hitbox_size: Vector2

@export var south_hitbox_position: Vector2
@export var south_hitbox_size: Vector2

@export var east_hitbox_position: Vector2
@export var east_hitbox_size: Vector2

@export var west_hitbox_position: Vector2
@export var west_hitbox_size: Vector2


