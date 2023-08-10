extends Container


const _ACTION_DICE_INFO_SCENE: PackedScene = preload("res://scenes/ui/battle/huds/popups_for_teams/popup_with_skill_info/elements_with_actions_dice/action_dice_info.tscn")
const _ACTION_DICE_ABILITY_INFO_SCENE: PackedScene = preload("res://scenes/ui/battle/huds/popups_for_teams/popup_with_skill_info/elements_with_actions_dice/action_dice_ability_info.tscn")

@onready var _skill_icon: TextureRect = $VBox/MainPanel/Margin/VBox/Header/SkillIcon
@onready var _title_label: Label = $VBox/MainPanel/Margin/VBox/Header/SkillTitle
@onready var _type_icon: TextureRect = $VBox/MainPanel/Margin/VBox/Header/SkillTypes/RangeType/Icon
@onready var _uses_type_label: Label = $VBox/MainPanel/Margin/VBox/Header/SkillTypes/UsesType/Type
@onready var _uses_count_label: Label = $VBox/MainPanel/Margin/VBox/Header/SkillTypes/UsesType/Counter
@onready var _skill_ability_label: RichTextLabel = $VBox/MainPanel/Margin/VBox/SkillAbilityDescription
@onready var _button_showing_dice_abilities: TextureButton = $VBox/MainPanel/Margin/VBox/ButtonShowingDiceAbilities
@onready var _dice_container: VBoxContainer = $ActionsDicePanel/Margin/ActionsDice
@onready var _dice_abilities_container: VBoxContainer = $VBox/AbilitiesVBox

@onready var _main_panel: PanelContainer = $VBox/MainPanel
@onready var _v_box_container: VBoxContainer = $VBox


func _ready() -> void:
	remove_skill()
	var action_dice_list: Array[AbstractActionDice] = [AbstractActionDice.new(), AbstractActionDice.new()]
	action_dice_list[1].dice_type = AbstractActionDice.DiceType.EVADE_DICE
	var skill: BaseSkill = BaseSkill.new()
	skill.action_dice_list = action_dice_list
	set_skill(skill)
	pass


func set_skill(skill: BaseSkill) -> void:
	_skill_icon.texture = skill.icon
	_title_label.text = skill.title
	_type_icon.texture.current_frame = skill.range_type
	_uses_type_label.text = BaseSkill.get_str_application_type(skill)
	_uses_count_label.text = str(skill.application_type_count)
	_set_skill_ability(skill.ability)
	_set_actions_dice(skill.action_dice_list)
	_button_showing_dice_abilities.visible = _dice_abilities_container.get_child_count() > 0


func remove_skill() -> void:
	for dice_info in _dice_container.get_children():
		_dice_container.remove_child(dice_info)
	for dice_abilities_info in _dice_abilities_container.get_children():
		_dice_abilities_container.remove_child(dice_abilities_info)


func _set_skill_ability(skill_ability: AbstractAbility) -> void:
	_skill_ability_label.text = skill_ability.description
	_skill_ability_label.visible = not skill_ability is NoAbility


func _set_actions_dice(actions_dice_list: Array[AbstractActionDice]) -> void:
	for i in actions_dice_list.size():
		var action_dice: AbstractActionDice = actions_dice_list[i]
		_create_action_dice_info(action_dice)
		_create_action_dice_ability_info(action_dice, i)


func _create_action_dice_info(action_dice: AbstractActionDice) -> void:
	var action_dice_info: Control = _ACTION_DICE_INFO_SCENE.instantiate()
	_dice_container.add_child(action_dice_info)
	action_dice_info.set_action_dice(action_dice)


func _create_action_dice_ability_info(action_dice: AbstractActionDice, dice_index: int) -> void:
	if action_dice.ability is NoAbility:
		return
	
	var action_dice_ability_info: Control = _ACTION_DICE_ABILITY_INFO_SCENE.instantiate()
	_dice_abilities_container.add_child(action_dice_ability_info)
	action_dice_ability_info.set_action_dice(action_dice, dice_index)


func _show_dice_abilities(tween: Tween) -> void:
	_dice_abilities_container.queue_sort()
	await get_tree().process_frame
	
	tween.tween_property(_dice_abilities_container, "modulate:a", 1, 0.2)
	var duration: float = 0.3
	for dice_abilities_info in _dice_abilities_container.get_children():
		tween.tween_property(
			dice_abilities_info, "position:y", dice_abilities_info.position.y, duration).from(-50)
		duration += 0.1


func _hide_dice_abilities(tween: Tween) -> void:
	tween.tween_property(_dice_abilities_container, "modulate:a", 0, 0.2)
	var duration: float = 0.3
	for dice_abilities_info in _dice_abilities_container.get_children():
		tween.tween_property(dice_abilities_info, "position:y", -50, duration)
		duration += 0.1


func _on_button_showing_dice_abilities_toggled(button_pressed: bool) -> void:
	var tween: Tween = get_tree().create_tween()\
			.set_ease(Tween.EASE_OUT)\
			.set_trans(Tween.TRANS_SPRING)\
			.set_parallel()
	
	if button_pressed:
		_hide_dice_abilities(tween)
	else:
		_show_dice_abilities(tween)
