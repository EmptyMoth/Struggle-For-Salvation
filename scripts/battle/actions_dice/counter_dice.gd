class_name CounterDice
extends OffensiveDice


func get_color() -> Color:
	return Color("E54646")


func _win_on_clash(_opponent_dice: AbstractActionDice) -> DiceAction:
	is_recycled = true
	return super(_opponent_dice)
