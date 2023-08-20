class_name ActionDiceInfo
extends VBoxContainer


@onready var _action_dice_range_label: Label = $DiceValue
@onready var _action_dice_icon: TextureRect = $DiceIcon


func set_info(action_dice: AbstractActionDice) -> void:
	_action_dice_range_label.text = "%s-%s" % [action_dice.min_value, action_dice.max_value]
	_action_dice_range_label.modulate = action_dice.get_color()
	_action_dice_icon.texture.current_frame = get_texture_frame_by_dice_type(action_dice)


func get_texture_frame_by_dice_type(action_dice: AbstractActionDice) -> int:
	if action_dice is AttackDice:
		return 0
	if action_dice is BlockDice:
		return 1
	if action_dice is EvadeDice:
		return 2
	return 3
