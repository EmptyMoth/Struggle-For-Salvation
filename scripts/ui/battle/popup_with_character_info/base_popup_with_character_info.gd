class_name BasePopupWithCharacterInfo
extends MarginContainer


const _DURATION_OF_PRIMARY_INFO: float = 0.3
const _DURATION_OF_SECONDARY_INFO: float = _DURATION_OF_PRIMARY_INFO + 0.1
const _DURATION_OF_TERTIARY_INFO: float = _DURATION_OF_SECONDARY_INFO + 0.1

var _current_tween: Tween = null
var _selected_skill: Skill = null

@onready var _base_info: PopupWithCharacterBaseInfo = $HBox/VBox/PopupWithCharacterBaseInfo
@onready var _additional_info: PopupWithCharacterAdditionalInfo = $HBox/VBox/PopupWithCharacterAdditionalInfo
@onready var _skill_info: PopupWithSkillInfo = $HBox/PopupWithSkillInfo


func _ready() -> void:
	_additional_info.skill_selected.connect(_on_skill_selected)
	_additional_info.skill_shown.connect(_on_skill_shown)
	_additional_info.skill_hidden.connect(_on_skill_hidden)
	close()


func set_info(character: Character, atp_slot: ATPSlot = null) -> void:
	_skill_info.hide()
	show_popup()
	_base_info.set_info(character)
	_additional_info.set_info(
			character.skills_manager.get_all_skills(), character.stats.passive_abilities)
	if atp_slot == null:
		_additional_info.open_passive_abilities_list()
		return
	_additional_info.open_skills_list()
	if atp_slot.assaulting_skill != null:
		_skill_info.show()
		_display_popup_with_skill(true)
		_skill_info.set_info(atp_slot.assaulting_skill)


func close() -> void:
	hide_popup()


func show_popup() -> void:
	_display_popup(true)

func hide_popup() -> void:
	_display_popup(false)


func _display_popup(is_displayed: bool) -> void:
	if _current_tween:
		_current_tween.kill()
	_current_tween = get_tree().create_tween()\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	_display_panel(_current_tween, _base_info, is_displayed, _DURATION_OF_PRIMARY_INFO)
	_display_panel(_current_tween, _additional_info, is_displayed, _DURATION_OF_SECONDARY_INFO)
	_display_popup_with_skill(is_displayed and _skill_info.visible)


func _display_popup_with_skill(is_displayed: bool) -> void:
	_current_tween = get_tree().create_tween()\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	_display_panel(_current_tween, _skill_info.main_panel, is_displayed, _DURATION_OF_SECONDARY_INFO)
	_display_panel(_current_tween, _skill_info.dice_list_panel, is_displayed, _DURATION_OF_TERTIARY_INFO)
	_skill_info.display_dice_abilities_panel(_current_tween, is_displayed, _DURATION_OF_TERTIARY_INFO)


func _display_panel(tween: Tween, panel: MovingContainer, is_displayed: bool, duration: float) -> void:
	var to: float = 0.0 if is_displayed else -(50.0 + panel.get_child(0).size.y)
	panel.move_container_from_current(tween, SIDE_TOP, to, duration)


func _on_skill_selected(skill: Skill) -> void:
	if _selected_skill == skill:
		_selected_skill = null
	else:
		_selected_skill = skill


func _on_skill_shown(skill: Skill) -> void:
	_skill_info.show()
	_skill_info.set_info(skill)
	_display_popup_with_skill(true)


func _on_skill_hidden(_skill: Skill) -> void:
	if _selected_skill != null:
		_on_skill_shown(_selected_skill)
	else:
		_display_popup_with_skill(false)
