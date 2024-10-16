class_name PopupWithSkillInfo
extends HBoxContainer


const _ACTION_DICE_INFO_SCENE: PackedScene = preload("res://scenes/ui/battle/popup_character_info/popup_skill_info/components/action_dice_info.tscn")
const _ACTION_DICE_ABILITY_INFO_SCENE: PackedScene = preload("res://scenes/ui/battle/popup_character_info/popup_skill_info/components/popup_dice_ability.tscn")

@export_group("Connections")
@export var _skill_icon: TextureRect
@export var _title_label: Label
@export var _type_icon: TextureRect
@export var _uses_type_label: Label
@export var _uses_count_label: Label
@export var _skill_ability_label: KeywordsRichTextLabel
@export var _button_hiding_dice_abilities: TextureButton
@export var _dice_container: VBoxContainer
@export var _dice_abilities_container: VBoxContainer


func set_info(skill: Skill) -> void:
	_set_base_skill_info(skill.stats)
	_set_skill_abilities_info(skill.stats.abilities)
	_set_actions_dice_info(skill.actions_dice)
	_button_hiding_dice_abilities.visible = _dice_abilities_container.get_child_count() > 0


func remove_actions_dice_info() -> void:
	for dice_info: Node in _dice_container.get_children():
		_dice_container.remove_child(dice_info)
	for dice_abilities_info: Node in _dice_abilities_container.get_children():
		_dice_abilities_container.remove_child(dice_abilities_info)


func is_visible_dice_abilities() -> bool:
	return not _button_hiding_dice_abilities.button_pressed


func make_left() -> void:
	move_child($VBox, 0)


func _set_base_skill_info(skill: SkillStats) -> void:
	_skill_icon.texture = skill.icon
	_title_label.text = skill.title
	_type_icon.texture.current_frame = 0 if skill.targets_count == 1 else 1
	var is_cooldown: bool = skill.use_type is CooldownData
	_uses_type_label.text = "Cooldown" if is_cooldown else "Quantity"
	_uses_count_label.text = str(
			skill.use_type.cooldown if is_cooldown else skill.use_type.quantity)


func _set_skill_abilities_info(abilities: Array[BaseSkillAbility]) -> void:
	_skill_ability_label.visible = abilities.size() > 0
	if _skill_ability_label.visible:
		_skill_ability_label.set_keywords_text(AbstractAbility.get_abilities_description(abilities))


func _set_actions_dice_info(actions_dice_list: Array[ActionDice]) -> void:
	remove_actions_dice_info()
	for i: int in actions_dice_list.size():
		var action_dice: ActionDice = actions_dice_list[i]
		_set_action_dice_info(action_dice)
		_set_action_dice_ability_info(action_dice, i)


func _set_action_dice_info(action_dice: ActionDice) -> void:
	var action_dice_info: ActionDiceInfo = _ACTION_DICE_INFO_SCENE.instantiate()
	_dice_container.add_child(action_dice_info)
	action_dice_info.set_info(action_dice)


func _set_action_dice_ability_info(action_dice: ActionDice, dice_index: int) -> void:
	if action_dice.stats.abilities.size() <= 0:
		return
	var action_dice_ability_info: PopupActionDiceAbility = _ACTION_DICE_ABILITY_INFO_SCENE.instantiate()
	_dice_abilities_container.add_child(action_dice_ability_info)
	action_dice_ability_info.set_info(action_dice, dice_index)


func _on_button_hiding_dice_abilities_toggled(on_toggle: bool) -> void:
	if not _dice_abilities_container.visible:
		_dice_abilities_container.show()
	await create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING)\
		.tween_property(_dice_abilities_container, "modulate:a", 1.0 if not on_toggle else 0.0, 0.2).finished
	_dice_abilities_container.visible = not on_toggle
