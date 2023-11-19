class_name OffensiveDice
extends ActionDiceCombatModel


func use_in_one_side(target: CharacterCombatModel) -> void:
	super(target)
	attack(target, model.values_model.get_current_value())


func attack(target: CharacterCombatModel, damage: int) -> void:
	target.take_damage(damage)
