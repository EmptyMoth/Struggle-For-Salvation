class_name BasePopupWithAssault
extends Control


const _ACTION_DICE_USE_INFO_SCENE: PackedScene = preload("res://scenes/ui/battle/popup_with_assault/components/action_dice_use_info.tscn")

@onready var _use_current_value: Label = $HBoxContainer/CurrentUse/Value
@onready var _use_skill_icon: TextureRect = $HBoxContainer/CurrentUse/Panel/CenterContainer/SkillIcon
@onready var _use_skill_title: Label = $HBoxContainer/VBoxContainer/MarginContainer2/SkillTitle
@onready var _use_dice_container: VBoxContainer = $HBoxContainer/CurrentUse/Panel/CenterContainer/Dice
@onready var _use_dice_icon: TextureRect = $HBoxContainer/CurrentUse/Panel/CenterContainer/Dice/DiceIcon
@onready var _use_dice_range: Label = $HBoxContainer/CurrentUse/Panel/CenterContainer/Dice/DiceRange
@onready var _dice_pool: HBoxContainer = $HBoxContainer/VBoxContainer/MarginContainer/DicePool


func set_info(character: CharacterCombatModel) -> void:
	position = character.model.view_model.position + Vector2(0, -300)
	character.chose_next_action_dice.connect(_on_character_chose_next_action_dice)
	character.calculated_comparing_value.connect(_on_character_calculated_comparing_value)
	character.used_action_dice.connect(_on_character_used_action_dice)


func _add_action_dice_use_info(dice: AbstractActionDice) -> void:
	var action_dice_use_info: ActionDiceUseInfo = _ACTION_DICE_USE_INFO_SCENE.instantiate()
	_dice_pool.add_child(action_dice_use_info)
	await _dice_pool.child_entered_tree
	action_dice_use_info.set_info(dice)


func _on_character_chose_next_action_dice(
			dice: AbstractActionDice, dice_pool: Array[ActionDiceCombatModel]) -> void:
	_use_skill_icon.texture = dice.wearer_skill.stats.icon
	_use_skill_title.text = dice.wearer_skill.stats.title
	_use_current_value.text = "0"
	_use_dice_container.hide()
	_use_skill_icon.show()
	for action_dice_use_info in _dice_pool.get_children():
		_dice_pool.remove_child(action_dice_use_info)
	_add_action_dice_use_info(dice)
	for combat_action_dice in dice_pool:
		_add_action_dice_use_info(combat_action_dice.model)


func _on_character_calculated_comparing_value(value: int) -> void:
	_use_current_value.text = str(value)
	_use_current_value.modulate = Color.WHITE_SMOKE


func _on_character_used_action_dice(dice: AbstractActionDice) -> void:
	_use_dice_icon.texture.current_frame = dice.stats.dice_type
	_use_dice_range.text = "%s-%s" % \
			[dice.values_model.get_min_value(), dice.values_model.get_max_value()]
	_use_dice_range.modulate = dice.color
	_use_current_value.text = str(dice.values_model.get_current_value())
	_use_current_value.modulate = dice.color
	_use_dice_container.show()
	_use_skill_icon.hide()
