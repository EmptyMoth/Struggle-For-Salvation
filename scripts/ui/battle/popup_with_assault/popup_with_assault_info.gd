class_name PopupWithAssaultInfo
extends HBoxContainer


const _ACTION_DICE_USE_INFO_SCENE: PackedScene = preload("res://scenes/ui/battle/popup_with_assault/components/action_dice_use_info.tscn")

@export var is_left: bool = false

var _character: Character

@onready var _final_value: Label = $VBox/FinalValue
@onready var _use_skill_icon: TextureRect = $VBox/Panel/Margin/SkillIcon
@onready var _use_skill_title: Label = $VBoxContainer/SkillTitle
@onready var _dice_list: HBoxContainer = $VBoxContainer/Panel/Margin/DiceList
@onready var _main_info: Control = $VBox


func _ready() -> void:
	pivot_offset = _main_info.size * Vector2(0.5, 1)
	if is_left:
		move_child($VBoxContainer, 0)
		_use_skill_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		($VBoxContainer/Panel as Control).size_flags_horizontal = Control.SIZE_SHRINK_END


func _process(_delta: float) -> void:
	position = _character.view_model.get_position_for_popup_assault_info() - _main_info.position - pivot_offset


func set_info(character: Character) -> void:
	_character = character
	var combat_character: CharacterCombatModel = character.combat_model
	var skill: Skill = combat_character.current_skill
	_use_skill_icon.texture = skill.stats.icon
	_use_skill_title.text = skill.stats.title
	character.combat_model.chose_next_action_dice.connect(_on_character_chose_next_action_dice)
	character.combat_model.calculated_comparing_value.connect(_on_character_calculated_comparing_value)


func _add_action_dice_use_info(dice: ActionDice) -> void:
	var action_dice_use_info: ActionDiceUseInfo = _ACTION_DICE_USE_INFO_SCENE.instantiate()
	_dice_list.add_child(action_dice_use_info)
	if is_left:
		_dice_list.move_child(action_dice_use_info, 0)
	await action_dice_use_info.ready
	action_dice_use_info.set_info(dice)


func _on_character_chose_next_action_dice(
			dice: ActionDice, dice_pool: Array[ActionDice]) -> void:
	_use_skill_icon.texture = dice.wearer_skill.stats.icon
	_use_skill_title.text = dice.wearer_skill.stats.title
	_final_value.text = ""
	for dice_info: Node in _dice_list.get_children():
		_dice_list.remove_child(dice_info)
	_add_action_dice_use_info(dice)
	for action_dice: ActionDice in dice_pool:
		_add_action_dice_use_info(action_dice)


func _on_character_calculated_comparing_value(value: int) -> void:
	_final_value.text = str(value)
	_final_value.modulate = _character.combat_model.current_action_dice.color
