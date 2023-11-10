class_name EvadeDice
extends AbstractActionDice


static func get_color() -> Color:
	return Color("EEEE48")


func _action(character: Character, _target: Character) -> void:
	character.mental_heal(get_current_value())
