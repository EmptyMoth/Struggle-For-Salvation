class_name PopupActionDiceAbility
extends MovingContainer


const _ROMAN_SYMBOLS: Array[String] = ["X", "IX", "V", "IV", "I"]
const _ARABIC_VALUES: Array[int] = [10, 9, 5, 4, 1]

@onready var _dice_number_label: Label = $Panel/Margin/HBox/DiceNumber
@onready var _dice_ability_label: KeywordsRichTextLabel = $Panel/Margin/HBox/DiceAbility


func set_info(action_dice: ActionDice, dice_index: int) -> void:
	_dice_number_label.text = _convert_to_roman(dice_index + 1)
	_dice_number_label.modulate = action_dice.color
	_dice_ability_label.set_keywords_text(
			AbstractAbility.get_abilities_description(action_dice.stats.abilities))


static func _convert_to_roman(number: int) -> String:
	var result: String = ""
	var index: int = 0
	while number > 0:
		while number >= _ARABIC_VALUES[index]:
			result += _ROMAN_SYMBOLS[index]
			number -= _ARABIC_VALUES[index]
		index += 1
	return result
