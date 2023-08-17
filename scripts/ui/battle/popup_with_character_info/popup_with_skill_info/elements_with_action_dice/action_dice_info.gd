class_name ActionDiceInfo
extends VBoxContainer


@onready var _action_dice_range_label: Label = $DiceValue
@onready var _action_dice_icon: TextureRect = $DiceIcon


func set_info(action_dice: AbstractActionDice) -> void:
	_action_dice_range_label.text = "%s-%s" % [action_dice.min_value, action_dice.max_value]
	_action_dice_icon.texture.current_frame = action_dice.dice_type
