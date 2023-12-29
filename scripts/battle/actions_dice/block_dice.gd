class_name BlockDice
extends DefensiveDice


static func _static_init() -> void:
	DEFAULT_ACTION = Action.new([ActionPart.new(Block.DEFAULT)])


func _to_string() -> String:
	return super() % "B"


func _win_clash(target: Character) -> void:
	super(target)
	var opponent_dice: ActionDice = target.combat_model.current_action_dice
	var damage: int = model.values_model.get_current_value()
	if opponent_dice.type == BattleEnums.ActionDiceType.ATTACK:
		damage -= opponent_dice.values_model.get_current_value()
	target.take_mental_damage(damage)
	defended.emit()
