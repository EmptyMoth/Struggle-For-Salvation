class_name BasePopupWithCharacterInfo
extends MarginContainer


const _DURATION_OF_PRIMARY_INFO: float = 0.3
const _DURATION_OF_SECONDARY_INFO: float = _DURATION_OF_PRIMARY_INFO + 0.1
const _DURATION_OF_TERTIARY_INFO: float = _DURATION_OF_SECONDARY_INFO + 0.1

@onready var _base_info: PopupWithCharacterBaseInfo = $HBox/VBox/PopupWithCharacterBaseInfo
@onready var _additional_info: PopupWithCharacterAdditionalInfo = $HBox/VBox/PopupWithCharacterAdditionalInfo
@onready var _skill_info: PopupWithSkillInfo = $HBox/PopupWithSkillInfo


func _ready() -> void:
	_additional_info.skill_selected.connect(_skill_info._on_skill_selected)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		hide_popup()
	if Input.is_action_just_pressed("ui_down"):
		show_popup()


func set_info(character: AbstractCharacter, speed_dice: AbstractSpeedDice = null) -> void:
	show_popup()
	_base_info.set_info(character)
	_additional_info.set_info(character.stats.skills, character.stats.passive_abilities)
	if speed_dice == null:
		_skill_info.hide()
		_additional_info.open_passive_abilities_list()
	else:
		_skill_info.show()
		_skill_info.set_info(speed_dice.installed_skill)
		_additional_info.open_skills_list()


func close() -> void:
	hide_popup()


func show_popup() -> void:
	_display_popup(true)

func hide_popup() -> void:
	_display_popup(false)


func _display_popup(is_displayed: bool) -> void:
	_display_panel(_base_info, is_displayed, _DURATION_OF_PRIMARY_INFO)
	_display_panel(_additional_info, is_displayed, _DURATION_OF_SECONDARY_INFO)
	if _skill_info.visible:
		_display_panel(_skill_info.main_panel, is_displayed, _DURATION_OF_SECONDARY_INFO)
		_display_panel(_skill_info.dice_list_panel, is_displayed, _DURATION_OF_TERTIARY_INFO)
		_skill_info.display_dice_abilities_panel(is_displayed, _DURATION_OF_TERTIARY_INFO)

func _display_panel(panel: MovingContainer, is_displayed: bool, duration: float) -> void:
	var tween: Tween = get_tree().create_tween()\
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	var to: float = 0.0 if is_displayed else -(50.0 + panel.size.y)
	panel.move_container_from_current(tween, SIDE_TOP, to, duration)
