class_name OffensiveDice
extends ActionDiceCombatModel


signal hit


func _init(dice: ActionDice) -> void:
	super(dice)
	action = dice.stats.action \
			if dice.stats.action != null \
			else Action.new([ActionPart.new(Evade.DEFAULT, Knockback.DEFAULT)]) 


func use_in_one_side(target: Character) -> void:
	super(target)
	attack(target, model.values_model.get_current_value())


func attack(target: Character, damage: int) -> void:
	target.health_manager.take_damage(damage)
	hit.emit()
