class_name PopupWithCharacterInfo
extends HBoxContainer


@export var is_left: bool = false

var _selected_skill: Skill = null

@onready var _base_info: PopupCharacterBaseInfo = $VBox/PopupCharacterBaseInfo
@onready var _additional_info: PopupWithCharacterAdditionalInfo = $VBox/PopupWithCharacterAdditionalInfo
@onready var _skill_info: PopupWithSkillInfo = $PopupSkillInfo


func _ready() -> void:
	if is_left:
		alignment = BoxContainer.ALIGNMENT_BEGIN
		move_child($VBox, 0)
		_base_info._character_icon.flip_h = false
		_skill_info.make_left()
	_additional_info.skill_selected.connect(_on_skill_selected)
	_additional_info.skill_shown.connect(_on_skill_shown)
	_additional_info.skill_hidden.connect(_on_skill_hidden)
	close()


func set_info(character: Character, atp_slot: ATPSlot = null) -> void:
	_skill_info.hide()
	show()
	_base_info.set_info(character)
	_additional_info.set_info(
			character.skills_manager.get_all_skills(), character.stats.passive_abilities)
	if atp_slot == null:
		_additional_info.open_passive_abilities_list()
		return
	_additional_info.open_skills_list()
	if atp_slot.assaulting_skill != null:
		_on_skill_shown(atp_slot.assaulting_skill)


func close() -> void: hide()


func _on_skill_selected(skill: Skill) -> void:
	_selected_skill = null if _selected_skill == skill else skill


func _on_skill_shown(skill: Skill) -> void:
	_skill_info.show()
	_skill_info.set_info(skill)


func _on_skill_hidden(_skill: Skill) -> void:
	if _selected_skill != null:
		_on_skill_shown(_selected_skill)
	else:
		_skill_info.hide()
