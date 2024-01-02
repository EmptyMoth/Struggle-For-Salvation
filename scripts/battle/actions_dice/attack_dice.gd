class_name AttackDice
extends OffensiveDice


func _init(dice: ActionDice) -> void:
	is_used_in_one_side = true
	super(dice)


func _to_string() -> String:
	return super() % "A"


func _win_clash(targets: Opponents) -> void:
	super(targets)
	var opponent_dice: ActionDice = targets.main.combat_model.current_action_dice
	var damage: int = model.values_model.get_current_value()
	if opponent_dice.type == BattleEnums.ActionDiceType.BLOCK:
		damage -= opponent_dice.values_model.get_current_value()
	attack(targets, damage)
