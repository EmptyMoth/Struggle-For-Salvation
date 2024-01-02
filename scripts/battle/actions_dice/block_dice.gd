class_name BlockDice
extends DefensiveDice


func _to_string() -> String:
	return super() % "B"


func _win_clash(targets: Opponents) -> void:
	super(targets)
	var opponent_dice: ActionDice = targets.main.combat_model.current_action_dice
	var damage: int = model.values_model.get_current_value()
	if opponent_dice.type == BattleEnums.ActionDiceType.ATTACK:
		damage -= opponent_dice.values_model.get_current_value()
	for target: Character in targets.get_all_opponents():
		target.health_manager.take_mental_damage(damage)
	defended.emit()
