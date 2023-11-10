class_name OffensiveDice
extends AbstractActionDice



func _action(_character: Character, target: Character) -> void:
	target.take_physical_damage(get_current_value() + bonus.physical_damage)
	target.take_mental_damage(get_current_value() + bonus.mental_damage)
