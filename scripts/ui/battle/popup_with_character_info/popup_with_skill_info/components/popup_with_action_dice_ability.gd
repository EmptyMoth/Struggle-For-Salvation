class_name PopupWithActionDiceAbility
extends MovingContainer


const _ROMAN_SYMBOLS: Array[String] = ["X", "IX", "V", "IV", "I"]
const _ARABIC_VALUES: Array[int] = [10, 9, 5, 4, 1]

@onready var _dice_number_label: Label = $Panel/Margin/HBox/ActionDiceNumber
@onready var _dice_ability_label: RichTextLabel = $Panel/Margin/HBox/ActionDiceAbility


func set_info(action_dice: ActionDiceStats, action_dice_index: int) -> void:
	_dice_number_label.text = PopupWithActionDiceAbility._convert_to_roman(action_dice_index + 1)
	_dice_number_label.modulate = action_dice.get_color()
	_dice_ability_label.text = AbstractAbility.get_abilities_description(
			action_dice.abilities as Array[AbstractAbility])


static func _convert_to_roman(number: int) -> String:
	var result: String = ""
	var index: int = 0
	while number > 0:
		while number >= _ARABIC_VALUES[index]:
			result += _ROMAN_SYMBOLS[index]
			number -= _ARABIC_VALUES[index]
		index += 1
	
	return result
