class_name OffensiveDice
extends ActionDiceCombatModel

signal hit


func use_in_one_side(target: Character) -> void:
	super(target)
	attack(target, model.values_model.get_current_value())


func attack(target: Character, damage: int) -> void:
	target.health_manager.take_damage(damage)
	hit.emit()
