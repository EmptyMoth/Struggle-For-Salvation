class_name DamageMotion
extends Knockback


static var DEFAULT: DamageMotion = DamageMotion.new()


func _init(_knockback_power: float = 3, _is_update_direction: bool = true) -> void:
	super(_knockback_power, _DEFAULT_DURATION, BattleEnums.CharactersMotions.DAMAGE, _is_update_direction)
