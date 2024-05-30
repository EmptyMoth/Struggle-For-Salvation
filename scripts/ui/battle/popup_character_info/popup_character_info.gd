class_name PopupWithCharacterInfo
extends MarginContainer


@export var is_left: bool = false

var _selected_skill: Skill = null

@onready var _base_info: PopupCharacterBaseInfo = $HBox/VBox/PopupCharacterBaseInfo
@onready var _passive_info: PopupPassiveInfo = $HBox/VBox/PopupPassiveInfo
@onready var _skill_info: PopupWithSkillInfo = $HBox/PopupSkillInfo

@onready var _main_tooltip_passive_description: TooltipPassiveDescription = $TooltipsPassiveDescription/Main
@onready var _added_tooltip_passive_description: TooltipPassiveDescription = $TooltipsPassiveDescription/Added


func _ready() -> void:
	if is_left:
		add_theme_constant_override("margin_right", 0)
		add_theme_constant_override("margin_left", 24)
		$HBox.alignment = BoxContainer.ALIGNMENT_BEGIN
		$HBox.move_child($HBox/VBox, 0)
		_base_info._character_icon.flip_h = false
		_skill_info.make_left()
		_main_tooltip_passive_description.make_left_sided()
		_added_tooltip_passive_description.make_left_sided()
	_base_info.button_hinding_passive.toggled.connect(_on_button_hinding_passive_toggled)
	_passive_info.passive_picked.connect(_on_popup_passive_picked)
	_passive_info.passive_selected.connect(_on_popup_passive_selected)
	_passive_info.passive_deselected.connect(_on_popup_passive_deselected)
	#_additional_info.skill_selected.connect(_on_skill_selected)
	#_additional_info.skill_shown.connect(_on_skill_shown)
	#_additional_info.skill_hidden.connect(_on_skill_hidden)
	_passive_info
	close()


func set_info(character: Character, atp_slot: ATPSlot = null) -> void:
	_skill_info.hide()
	show()
	_base_info.set_info(character)
	if character.stats.has_ability():
		_base_info.button_hinding_passive.show()
		_passive_info.show()
		_passive_info.set_passives(character.stats.passive_abilities)
	else:
		_base_info.button_hinding_passive.hide()
		_passive_info.hide()
	if atp_slot != null and atp_slot.assaulting_skill != null:
		_on_skill_shown(atp_slot.assaulting_skill)


func close() -> void: hide()


func _on_button_hinding_passive_toggled(on_toggle: bool) -> void:
	_passive_info.visible = not on_toggle


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


func _on_popup_passive_picked(passive: BaseCharacterAbility, tooltip_position: Vector2) -> void:
	if _main_tooltip_passive_description.is_fixed:
		_added_tooltip_passive_description.hide()
		_main_tooltip_passive_description.set_description(passive._get_description())
		_main_tooltip_passive_description.position = _added_tooltip_passive_description.position
	else:
		_main_tooltip_passive_description.is_fixed = true

func _on_popup_passive_selected(passive: BaseCharacterAbility, tooltip_position: Vector2) -> void:
	_set_passive_tooltip(_added_tooltip_passive_description 
		if _main_tooltip_passive_description.visible 
		else _main_tooltip_passive_description, 
		passive, tooltip_position)

func _on_popup_passive_deselected(passive: BaseCharacterAbility, tooltip_position: Vector2) -> void:
	if _added_tooltip_passive_description.visible:
		_added_tooltip_passive_description.hide()
	elif not _main_tooltip_passive_description.is_fixed:
		_main_tooltip_passive_description.hide()

func _set_passive_tooltip(tooltip: TooltipPassiveDescription,
			passive: BaseCharacterAbility, tooltip_position: Vector2) -> void:
	tooltip.global_position = _passive_info.global_position + (_passive_info.size if is_left else Vector2.ZERO)
	tooltip.global_position.y = tooltip_position.y
	tooltip.set_description(passive._get_description())
	tooltip.show()
