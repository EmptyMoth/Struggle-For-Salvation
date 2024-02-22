class_name TakeDamageEffect
extends AbstractAbilityEffect


@export_range(1, 100, 1, "or_greater") var _damage_count: int = 1


func get_description() -> String:
	return "Takes %s damage" % _damage_count


func effect(character: Character = null, skill: Skill = null, dice: ActionDice = null) -> void:
	character.health_manager.take_physical_damage(DamageInfo.new(
		_damage_count, character, BattleEnums.DamageSourceType.ABILITY))
