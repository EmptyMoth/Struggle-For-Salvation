class_name ActionDiceUseInfo
extends VBoxContainer


var _action_dice: AbstractActionDice

@onready var _dice_range_label: Label = $DiceRange
@onready var _dice_value_label: Label = $DiceValue
@onready var _dice_icon: TextureRect = $DiceIcon


func set_info(action_dice: AbstractActionDice) -> void:
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
	_dice_value_label.modulate = _action_dice.color
	_dice_value_label.show()


func _on_action_dice_used() -> void:
	queue_free()

func _on_action_dice_destroyed() -> void:
	queue_free()
