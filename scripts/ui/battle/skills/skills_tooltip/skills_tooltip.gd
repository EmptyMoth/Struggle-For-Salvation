extends Tooltip


const _MAX_ACTION_DICE_COUNT = 7

#@onready var _skill_icon: TextureRect = $VBoxContainer/MainPanel/SkillBaseInformation/HeaderMargin/Header/SkillIcon
#@onready var _skill_title_label: Label = $VBoxContainer/MainPanel/SkillBaseInformation/HeaderMargin/Header/SkillTitle
#@onready var _skill_type_icon: TextureRect = $VBoxContainer/MainPanel/SkillBaseInformation/HeaderMargin/Header/GridContainer/TypeIcon
#@onready var _skill_uses_type_label: Label = $VBoxContainer/MainPanel/SkillBaseInformation/HeaderMargin/Header/GridContainer/UsesType
#@onready var _skill_uses_count_label: Label = $VBoxContainer/MainPanel/SkillBaseInformation/HeaderMargin/Header/GridContainer/UsesCount
#@onready var _skill_ability_label: RichTextLabel = $VBoxContainer/MainPanel/SkillBaseInformation/MainMargin/SkillAbility
#@onready var _dice_container: HBoxContainer = $VBoxContainer/MainPanel/SkillBaseInformation/FooterMargin/Footer/DiceContainer
#@onready var _view_dice_ability_button: Button = $VBoxContainer/MainPanel/SkillBaseInformation/FooterMargin/Footer/ViewDiceAbilityButton
#@onready var _dice_abilities_container: VBoxContainer = $VBoxContainer/DiceAbilityContainer


func _ready() -> void:
	pass
	#_create_action_dice_tooltips()


#func set_skill_information(skill: BaseSkill) -> void:
#	_skill_icon.texture = skill.icon
#	_skill_title_label.text = skill.title
#	_skill_type_icon.texture.current_frame = skill.range_type
#	_skill_uses_type_label.text = BaseSkill.get_str_uses_type(skill)
#	_skill_uses_count_label.text = str(skill.uses_count_in_turn)
#	_set_skill_ability(skill.ability)
#	_set_action_dice(skill.action_dice_list)
#
#
#func _set_skill_ability(skill_ability: SkillAbility) -> void:
#	if skill_ability == null:
#		_skill_ability_label.hide()
#		return
#
#	_skill_ability_label.text = skill_ability.description
#	_skill_ability_label.show()
#
#
#func _set_action_dice(action_dice_list: Array[AbstractActionDice]) -> void:
#	_set_action_dice_information(action_dice_list)
#	_remove_action_dice_information(action_dice_list.size())
#
#
#func _set_action_dice_information(action_dice_list: Array[AbstractActionDice]) -> void:
#	for dice_index in action_dice_list.size():
#		var action_dice: AbstractActionDice = action_dice_list[dice_index]
#		for container in [_dice_container, _dice_abilities_container]:
#			container.get_child(dice_index).set_action_dice_information(action_dice, dice_index)
#
#
#func _remove_action_dice_information(action_dice_count: int) -> void:
#	for index_tooltip in range(action_dice_count, _MAX_ACTION_DICE_COUNT):
#		for container in [_dice_container, _dice_abilities_container]:
#			container.get_child(index_tooltip).remove_action_dice_information()
#
#
#func _create_action_dice_tooltips() -> void:
#	var _action_dice_tooltip_packed: PackedScene = preload("res://scenes/ui/battle_ui/skills/skills_tooltip/tooltip_elements/action_dice_tooltip.tscn")
#	var _actiom_dice_ability_tooltip_packed: PackedScene = preload("res://scenes/ui/battle_ui/skills/skills_tooltip/tooltip_elements/action_dice_ability_tooltip.tscn")
#	for i in _MAX_ACTION_DICE_COUNT:
#		var _action_dice_tooltip = _action_dice_tooltip_packed.instantiate()
#		_action_dice_tooltip.hide()
#		_dice_container	.add_child(_action_dice_tooltip)
#		var _actiom_dice_ability_tooltip = _actiom_dice_ability_tooltip_packed.instantiate()
#		_dice_abilities_container.add_child(_actiom_dice_ability_tooltip)
#		_actiom_dice_ability_tooltip.hide()
