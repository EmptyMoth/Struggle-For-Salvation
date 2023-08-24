class_name OffensiveDice
extends AbstractActionDice


func _win_on_clash(_opponent_dice: AbstractActionDice) -> DiceAction:
	if _opponent_dice is BlockDice:
		bonus.physical_damage -= _opponent_dice.get_current_value()
		bonus.mental_damage -= _opponent_dice.get_current_value()
	return super(_opponent_dice)


func _action(character: AbstractCharacter, target: AbstractCharacter) -> void:
	target.take_physical_damage(get_current_value() + bonus.physical_damage)
	target.take_mental_damage(get_current_value() + bonus.mental_damage)
