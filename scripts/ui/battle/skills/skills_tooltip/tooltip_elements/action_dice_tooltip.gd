extends VBoxContainer


@onready var _action_dice_value_label: Label = $DiceValue
@onready var _action_dice_icon: TextureRect = $DiceIcon


func set_action_dice_information(
			action_dice: AbstractActionDice, _action_dice_index: int) -> void:
	_action_dice_value_label.text = "%s-%s" % [action_dice.min_value, action_dice.max_value]
	_action_dice_icon.texture.current_frame = action_dice.dice_type
	show()


func remove_action_dice_information() -> void:
	hide()
