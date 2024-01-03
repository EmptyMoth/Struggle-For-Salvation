class_name DamageMotion
extends KnockbackMotion


static var DEFAULT: DamageMotion = DamageMotion.new()


func _init(_knockback_power: float = 3, _is_update_direction: bool = true) -> void:
	super(_knockback_power, DEFAULT_DURATION, BattleEnums.CharactersMotions.DAMAGE, _is_update_direction)


func _create_additional_position(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> Vector3:
	return super(character, main_opponent, sub_targets)
