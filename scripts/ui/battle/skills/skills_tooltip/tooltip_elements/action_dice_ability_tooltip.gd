extends Control


@onready var _action_dice_number_label: Label = $MarginContainer/DiceAbilityInformation/DiceNumber
@onready var _action_dice_ability_label: Label = $MarginContainer/DiceAbilityInformation/Ability


func set_action_dice_information(
			action_dice: AbstractActionDice, action_dice_index: int) -> void:
	_action_dice_number_label.text = str(action_dice_index + 1)
	_action_dice_ability_label.text = action_dice.ability.description
	show()


func remove_action_dice_information() -> void:
	hide()
