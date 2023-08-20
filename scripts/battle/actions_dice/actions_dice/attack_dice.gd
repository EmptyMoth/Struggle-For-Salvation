class_name AttackDice
extends AbstractActionDice


func get_color() -> Color:
	return Color("E54646")


func _winning_a_clash() -> AbstractDiceAction:
	return AbstractDiceAction.new()


func _drawing_a_clash() -> AbstractDiceAction:
	return AbstractDiceAction.new()


func _losing_a_clash() -> AbstractDiceAction:
	return AbstractDiceAction.new()
