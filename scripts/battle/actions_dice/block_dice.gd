class_name BlockDice
extends AbstractActionDice


func get_color() -> Color:
	return Color("E54646")


func _win_on_clash(_opponent_dice: AbstractActionDice) -> DiceAction:
	if _opponent_dice is OffensiveDice:
		bonus.mental_damage -= _opponent_dice.get_current_value()
	return stats.action.init(_action)


func _action(character: AbstractCharacter, target: AbstractCharacter) -> void:
	target.take_mental_damage(get_current_value() + bonus.mental_damage)
