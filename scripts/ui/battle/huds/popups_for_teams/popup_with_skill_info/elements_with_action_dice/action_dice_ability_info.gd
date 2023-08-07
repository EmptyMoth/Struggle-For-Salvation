extends Control


const _ROMAN_SYMBOLS: Array[String] = ["X", "IX", "V", "IV", "I"]
const _ARABIC_VALUES: Array[int] = [10, 9, 5, 4, 1]

@onready var _action_dice_number_label: Label = $Margin/HBox/ActionDiceNumber
@onready var _action_dice_ability_label: RichTextLabel = $Margin/HBox/ActionDiceAbility


func set_action_dice(action_dice: AbstractActionDice, action_dice_index: int) -> void:
	_action_dice_number_label.text = _convert_to_roman(action_dice_index + 1)
	_action_dice_ability_label.text = action_dice.ability.description


static func _convert_to_roman(number: int) -> String:
	var result: String = ""
	var index: int = 0
	while number > 0:
		while number >= _ARABIC_VALUES[index]:
			result += _ROMAN_SYMBOLS[index]
			number -= _ARABIC_VALUES[index]
		index += 1
	
	return result
