class_name BlockDice
extends AbstractActionDice


static func get_color() -> Color:
	return Color("E54646")


func _action(_character: Character, target: Character) -> void:
	target.take_mental_damage(get_current_value() + bonus.mental_damage)
