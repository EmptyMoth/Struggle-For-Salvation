class_name PopupWithSkillInfo
extends MovingContainer


const _ACTION_DICE_INFO_SCENE: PackedScene = preload("res://scenes/ui/battle/popup_with_character_info/popup_with_skill_info/components/action_dice_info.tscn")
const _ACTION_DICE_ABILITY_INFO_SCENE: PackedScene = preload("res://scenes/ui/battle/popup_with_character_info/popup_with_skill_info/components/action_dice_ability_info.tscn")

@onready var main_panel: MovingContainer = $HBox/VBox/MainPanel
@onready var dice_list_panel: MovingContainer = $HBox/ActionsDiceList

@onready var _skill_icon: TextureRect = $HBox/VBox/MainPanel/Panel/Margin/VBox/Header/SkillIcon
@onready var _title_label: Label = $HBox/VBox/MainPanel/Panel/Margin/VBox/Header/SkillTitle
@onready var _type_icon: TextureRect = $HBox/VBox/MainPanel/Panel/Margin/VBox/Header/SkillTypes/RangeType/Icon
@onready var _uses_type_label: Label = $HBox/VBox/MainPanel/Panel/Margin/VBox/Header/SkillTypes/UsesType/Type
@onready var _uses_count_label: Label = $HBox/VBox/MainPanel/Panel/Margin/VBox/Header/SkillTypes/UsesType/Counter
@onready var _skill_ability_label: RichTextLabel = $HBox/VBox/MainPanel/Panel/Margin/VBox/SkillAbilityDescription
@onready var _button_hiding_dice_abilities: TextureButton = $HBox/VBox/MainPanel/Panel/Margin/VBox/ButtonHidingDiceAbilities
@onready var _dice_container: VBoxContainer = $HBox/ActionsDiceList/Panel/Margin/ActionsDice
@onready var _dice_abilities_container: VBoxContainer = $HBox/VBox/AbilitiesVBox


func set_info(skill: AbstractSkill) -> void:
	if skill == null:
		return
	
#	_set_base_info(skill)
#	_set_skill_ability(skill.ability)
#	_set_actions_dice(skill.action_dice_list)
#	_button_hiding_dice_abilities.visible = _dice_abilities_container.get_child_count() > 0


func remove_actions_dice_info() -> void:
	for dice_info in _dice_container.get_children():
		_dice_container.remove_child(dice_info)
	for dice_abilities_info in _dice_abilities_container.get_children():
		_dice_abilities_container.remove_child(dice_abilities_info)


func display_dice_abilities_panel(is_displayed: bool, duration: float) -> void:
	if not is_visible_dice_abilities():
		return
	
	var tween: Tween = get_tree().create_tween()\
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(_dice_abilities_container, "modulate:a", 1 if is_displayed else 0, 0.2)
	var number: int = 0
	for dice_abilities_info in _dice_abilities_container.get_children():
		number += 1
		dice_abilities_info.move_container_from_current(tween, SIDE_TOP, 
				0 if is_displayed else -50 * number, duration + 0.1 * number)


func is_visible_dice_abilities() -> bool:
	return not _button_hiding_dice_abilities.button_pressed


func _set_base_info(skill: AbstractSkillStats) -> void:
	_skill_icon.texture = skill.icon
	_title_label.text = skill.title
	_type_icon.texture.current_frame = skill.range_type
	if skill is CooldownSkillStats:
		_uses_type_label.text = "Cooldown"
		_uses_count_label.text = skill.cooldown
	elif skill is QuantitySkillStats:
		_uses_type_label.text = "Quantity"
		_uses_count_label.text = skill.quantity


func _set_skill_ability(skill_ability: AbstractAbility) -> void:
	_skill_ability_label.text = skill_ability.description
	_skill_ability_label.visible = not skill_ability is NoAbility


func _set_actions_dice(actions_dice_list: Array[AbstractActionDice]) -> void:
	remove_actions_dice_info()
	for i in actions_dice_list.size():
		var action_dice: AbstractActionDice = actions_dice_list[i]
		_create_action_dice_info(action_dice)
		_create_action_dice_ability_info(action_dice, i)


func _create_action_dice_info(action_dice: AbstractActionDice) -> void:
	var action_dice_info: ActionDiceInfo = _ACTION_DICE_INFO_SCENE.instantiate()
	_dice_container.add_child(action_dice_info)
	action_dice_info.set_info(action_dice)


func _create_action_dice_ability_info(action_dice: AbstractActionDice, dice_index: int) -> void:
	if action_dice.ability is NoAbility:
		return
	
	var action_dice_ability_info: ActionDiceAbilityInfo = _ACTION_DICE_ABILITY_INFO_SCENE.instantiate()
	_dice_abilities_container.add_child(action_dice_ability_info)
	action_dice_ability_info.set_info(action_dice, dice_index)


func _on_button_hiding_dice_abilities_toggled(button_pressed: bool) -> void:
	display_dice_abilities_panel(not button_pressed, 0.2)


func _on_skill_selected(skill: AbstractSkill) -> void:
	set_info(skill)
