class_name AttackDice
extends OffensiveDice


func get_color() -> Color:
	return Color("E54646")


func use_on_one_side() -> DiceAction:
	return stats.action.init(_action)
