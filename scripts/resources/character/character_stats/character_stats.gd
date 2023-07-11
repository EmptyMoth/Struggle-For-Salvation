class_name CharacterStats
extends Resource


@export var character_name: String = ''
@export var character_type: BattleParameters.CharactersTypes

@export_group("Health")
@export_range(1, 1000, 1) var max_physical_health: int = 1
@export_range(1, 1000, 1) var max_mental_health: int = 1

@export_group("Resistances")
@export var physical_resistance: BaseResistance.Resistance = BaseResistance.Resistance.NORMAL
@export var mental_resistance: BaseResistance.Resistance = BaseResistance.Resistance.NORMAL

@export_group("Speed Dice")
@export_range(1, 99, 1) var min_speed: int = 1
@export_range(1, 99, 1) var max_speed: int = 1
@export_range(1, 10, 1) var speed_dice_count: int = 1
