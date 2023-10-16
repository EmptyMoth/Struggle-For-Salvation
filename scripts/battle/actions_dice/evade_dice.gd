class_name EvadeDice
extends AbstractActionDice


func get_color() -> Color:
	return Color("EEEE48")


func _lose_on_win(opponent_dice: AbstractActionDice) -> DiceAction:
	if opponent_dice is OffensiveDice:
		is_recycled = true
	return stats.action.init(_action)


func _action(character: Character, _target: Character) -> void:
	character.mental_heal(get_current_value())
