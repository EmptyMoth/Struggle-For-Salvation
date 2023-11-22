class_name AttackDice
extends OffensiveDice


func _init(dice: AbstractActionDice) -> void:
	is_used_in_one_side = true
	super(dice)


func _to_string() -> String:
	return super() % "A"


func _win_clash(target: Character) -> void:
	super(target)
	var opponent_dice: ActionDiceCombatModel = target.current_action_dice.combat_model
	var damage: int = model.values_model.get_current_value()
	if opponent_dice is BlockDice:
		damage -= opponent_dice.model.values_model.get_current_value()
	attack(target, damage)
