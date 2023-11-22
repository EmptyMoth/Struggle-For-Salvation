class_name BlockDice
extends DefensiveDice


func _to_string() -> String:
	return super() % "B"


func _win_clash(target: Character) -> void:
	super(target)
	var opponent_dice: ActionDiceCombatModel = target.current_action_dice.combat_model
	var damage: int = model.values_model.get_current_value()
	if opponent_dice is AttackDice:
		damage -= opponent_dice.model.values_model.get_current_value()
	target.take_mental_damage(damage)
	defended.emit()
