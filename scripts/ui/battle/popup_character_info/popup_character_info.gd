class_name PopupWithCharacterInfo
extends MarginContainer


@export var is_left: bool = false

var _selected_skill: Skill = null

@onready var _base_info: PopupCharacterBaseInfo = $HBox/VBox/PopupCharacterBaseInfo
@onready var _passive_info: PopupPassiveInfo = $HBox/VBox/PopupPassiveInfo
@onready var _skill_info: PopupWithSkillInfo = $HBox/PopupSkillInfo

@onready var _tooltip_passive_description: TooltipPassiveDescription = $TooltipsPassiveDescription/Main


func _ready() -> void:
	if is_left:
		_make_left()
	_base_info.button_hinding_passive.toggled.connect(_on_button_hinding_passive_toggled)
	_passive_info.init(_tooltip_passive_description, is_left)	
	close()


func set_info(character: Character, atp_slot: ATPSlot = null) -> void:
	_prepare()
	show()
	_base_info.set_info(character)
	if character.stats.has_ability():
		_base_info.button_hinding_passive.show()
		_passive_info.set_passives(character.stats.passive_abilities)
		if not _base_info.button_hinding_passive.button_pressed:
			_passive_info.show()
	if atp_slot != null and atp_slot.assaulting_skill != null:
		_selected_skill = atp_slot.assaulting_skill
		_on_skill_button_selected(atp_slot.assaulting_skill)


func close() -> void: hide()


func _prepare() -> void:
	_skill_info.hide()
	_passive_info.hide()
	_base_info.button_hinding_passive.hide()
	#_base_info.button_hinding_passive.set_pressed_no_signal(false)
	_tooltip_passive_description.hide()
	_tooltip_passive_description.is_fixed = false


func _make_left() -> void:
	add_theme_constant_override("margin_right", 0)
	add_theme_constant_override("margin_left", 24)
	$HBox.alignment = BoxContainer.ALIGNMENT_BEGIN
	$HBox.move_child($HBox/VBox, 0)
	_base_info.make_left()
	_skill_info.make_left()
	_tooltip_passive_description.make_left_sided()


func _on_button_hinding_passive_toggled(on_toggle: bool) -> void:
	if not _passive_info.visible:
		_passive_info.show()
	await create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING)\
		.tween_property(_passive_info, "modulate:a", 1.0 if not on_toggle else 0.0, 0.2).finished
	_passive_info.visible = not on_toggle
	if on_toggle:
		_passive_info.close()
		_tooltip_passive_description.hide()
		_tooltip_passive_description.is_fixed = false


func _on_skill_button_picked(skill: Skill) -> void:
	_selected_skill = null if _selected_skill == skill else skill

func _on_skill_button_selected(skill: Skill) -> void:
	_skill_info.show()
	_skill_info.set_info(skill)

func _on_skill_button_deselected(skill: Skill) -> void:
	if _selected_skill != null:
		_on_skill_button_selected(_selected_skill)
	else:
		_skill_info.hide()
