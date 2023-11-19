class_name ActionDiceInfo
extends VBoxContainer


@onready var _action_dice_range_label: Label = $DiceRange
@onready var _action_dice_icon: TextureRect = $DiceIcon


func set_info(action_dice: AbstractActionDice) -> void:
	_action_dice_range_label.text = "%s-%s" % \
			[action_dice.values_model.get_min_value(), action_dice.values_model.get_max_value()]
	_action_dice_range_label.modulate = action_dice.color
	_action_dice_icon.texture.current_frame = action_dice.stats.dice_type
