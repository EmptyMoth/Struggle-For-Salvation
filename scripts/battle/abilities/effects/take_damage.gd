class_name TakeDamageEffect
extends AbstractAbilityEffect


@export_range(1, 100, 1, "or_greater") var _damage_count: int = 1


func get_description() -> String:
	return "Takes %s damage" % _damage_count


func effect(_target: Character) -> void:
	_wearer.health_manager.take_physical_damage(DamageInfo.new(
		_damage_count, _wearer, BattleEnums.DamageSourceType.ABILITY))
