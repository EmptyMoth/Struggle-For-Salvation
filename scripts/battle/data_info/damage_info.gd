class_name DamageInfo
extends Resource


var attacker: Character
var target: Character
var damage_sent: int
var damage_received: int
var resistance: BaseResistance.ResistanceType = -1
var dice_gain_multiplier: float
var damage_type: BattleEnums.DamageType
var damage_source: BattleEnums.DamageSourceType
var is_permanent: bool


func _init(
		_damage_sent: int,
		_target: Character,
		_damage_source: BattleEnums.DamageSourceType,
		_attacker: Character = null,
		_dice_gain_multiplier: float = 1.0) -> void:
	damage_source = _damage_source
	damage_sent = _damage_sent
	attacker = _attacker
	target = _target
	dice_gain_multiplier = _dice_gain_multiplier
	is_permanent = damage_source != BattleEnums.DamageSourceType.ATTACK
