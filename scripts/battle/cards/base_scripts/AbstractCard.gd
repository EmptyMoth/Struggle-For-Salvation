class_name AbstractCard
extends Node


enum CardType { MELEE, RANGED, MASS_SUMMATION, MASS_INDIVIDUAL }

@export var card_name: String = ''
@export var card_type: CardType
@export_range(0, 10, 1) var cooldown_time: int = 0
@export_range(1, 5, 1) var uses_count: int = 1
@export var art: Texture2D

var ability: AbstractAbility
