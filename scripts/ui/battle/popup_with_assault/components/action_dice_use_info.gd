class_name ActionDiceUseInfo
extends VBoxContainer


static var _COLOR_BY_DICE_TYPE: Array[Color] = [
		Color("EB8D8D"), Color("ADC4F1"), Color("B7F1C4"), Color("E9E9B6")]

var _action_dice: ActionDice

@onready var _dice_range_label: Label = $DiceRange
@onready var _dice_value_label: Label = $Center/DiceValue
@onready var _dice_icon: TextureRect = $Center/DiceIcon


func set_info(action_dice: ActionDice) -> void:
	_action_dice = action_dice
	action_dice.values_model.rolled.connect(_on_action_dice_rolled)
	action_dice.combat_model.dice_used.connect(_on_action_dice_used)
	action_dice.combat_model.destroyed.connect(_on_action_dice_destroyed)
	_dice_icon.texture.current_frame = action_dice.stats.dice_type
	_dice_range_label.text = "%s-%s" % \
			[action_dice.values_model.get_min_value(), action_dice.values_model.get_max_value()]
	_dice_range_label.modulate = action_dice.color
	_dice_value_label.hide()


func _on_action_dice_rolled() -> void:
	_dice_value_label.text = str(_action_dice.values_model.get_current_value())
	_dice_value_label.font_color = _COLOR_BY_DICE_TYPE[_action_dice.type]
	_dice_value_label.show()


func _on_action_dice_used() -> void:
	queue_free()

func _on_action_dice_destroyed() -> void:
	queue_free()
