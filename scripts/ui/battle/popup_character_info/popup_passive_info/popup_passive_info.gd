class_name PopupPassiveInfo
extends PanelContainer


const _TITLE_PASSIVE_BUTTON_PACKED: PackedScene = preload("res://scenes/ui/battle/popup_character_info/popup_passive_info/components/title_passive_button.tscn")

var _button_group: ButtonGroup = ButtonGroup.new()
var _picked_passive_button: TitlePassiveButton = null
var _passive_tooltip: TooltipPassiveDescription
var _is_left: bool

@export var _passive_abilities_list: VBoxContainer


func init(passive_tooltip: TooltipPassiveDescription, is_left: bool) -> void:
	_passive_tooltip = passive_tooltip
	_is_left = is_left


func close() -> void:
	if _picked_passive_button != null:
		_picked_passive_button.button_pressed = false
	_picked_passive_button = null


func set_passives(passives_abilities: Array) -> void:
	_clear_passive_list()
	_add_passive_list(passives_abilities)


func _clear_passive_list() -> void:
	for old_passive: Node in _passive_abilities_list.get_children():
		_passive_abilities_list.remove_child(old_passive)


func _add_passive_list(passives_abilities: Array) -> void:
	for passive: BaseCharacterAbility in passives_abilities:
		var passive_button: TitlePassiveButton = _TITLE_PASSIVE_BUTTON_PACKED.instantiate()
		_passive_abilities_list.add_child(passive_button)
		passive_button.button_group = _button_group
		passive_button.passive_picked.connect(_on_passive_button_picked)
		passive_button.passive_selected.connect(_on_passive_button_selected)
		passive_button.passive_deselected.connect(_on_passive_button_deselected)
		passive_button.set_passive(passive)


func _setup_passive_tooltip(passive_button: TitlePassiveButton) -> void:
	@warning_ignore("incompatible_ternary")
	_passive_tooltip.global_position.x = global_position.x + (size.x if _is_left else 0)
	_passive_tooltip.global_position.y = passive_button.get_tooltip_position_by_y()
	_passive_tooltip.set_description(passive_button.setted_passive._get_description())


func _on_passive_button_picked(passive_button: TitlePassiveButton) -> void:
	if _picked_passive_button == passive_button:
		_picked_passive_button.button_pressed = false
		_picked_passive_button = null
		_passive_tooltip.is_fixed = false
		return
	_picked_passive_button = passive_button
	_passive_tooltip.is_fixed = true

func _on_passive_button_selected(passive_button: TitlePassiveButton) -> void:
	if passive_button == _picked_passive_button:
		return
	_setup_passive_tooltip(passive_button)
	_passive_tooltip.show()

func _on_passive_button_deselected(passive_button: TitlePassiveButton) -> void:
	if passive_button == _picked_passive_button:
		return
	if not _passive_tooltip.is_fixed:
		_passive_tooltip.hide()
		return
	_setup_passive_tooltip(_picked_passive_button)
