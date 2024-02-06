class_name OffensiveDice
extends ActionDiceCombatModel


signal hit


func use_in_one_side(targets: Opponents) -> void:
	super(targets)
	attack(targets, model.values_model.get_current_value())


func attack(targets: Opponents, damage: int) -> void:
	for target: Character in targets.get_all_opponents():
		target.health_manager.take_damage(DamageInfo.new(
				damage, target, BattleEnums.DamageSourceType.ATTACK, 
				model.wearer, model.values_model.get_extra_power_multiplier()))
	hit.emit()
