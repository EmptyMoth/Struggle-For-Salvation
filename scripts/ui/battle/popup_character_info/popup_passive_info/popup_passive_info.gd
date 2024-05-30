class_name PopupPassiveInfo
extends PanelContainer


signal passive_picked(passive: BaseCharacterAbility, tooltip_position: Vector2)
signal passive_selected(passive: BaseCharacterAbility, tooltip_position: Vector2)
signal passive_deselected(passive: BaseCharacterAbility, tooltip_position: Vector2)

const _TITLE_PASSIVE_BUTTON_PACKED: PackedScene = preload("res://scenes/ui/battle/popup_character_info/popup_passive_info/components/title_passive_button.tscn")

var _button_group: ButtonGroup = ButtonGroup.new()

@onready var _passive_abilities_list: VBoxContainer = $Margin/HBox/VBox


func set_passives(passives_abilities: Array) -> void:
	_clear_passive_list()
	_add_passive_list(passives_abilities)


func _clear_passive_list() -> void:
	for old_passive: Node in _passive_abilities_list.get_children():
		_passive_abilities_list.remove_child(old_passive)


func _add_passive_list(passives_abilities: Array) -> void:
	for passive: BaseCharacterAbility in passives_abilities:
		var passive_button: TitlePassiveButton = _TITLE_PASSIVE_BUTTON_PACKED.instantiate()
		passive_button.passive_picked = passive_picked
		passive_button.passive_selected = passive_selected
		passive_button.passive_deselected = passive_deselected
		_passive_abilities_list.add_child(passive_button)
		passive_button._passive_button.button_group = _button_group
		passive_button.set_passive(passive)
