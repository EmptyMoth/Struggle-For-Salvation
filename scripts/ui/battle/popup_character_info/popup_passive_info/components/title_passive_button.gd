class_name TitlePassiveButton
extends PanelContainer


signal pressed

var passive_picked: Signal
var passive_selected: Signal
var passive_deselected: Signal

var _passive: BaseCharacterAbility
var _tween: Tween

@onready var _passive_button: Button = $Margin/Button
@onready var _margin_button: MarginContainer = $Margin
@onready var _selected_background: SelectedButtonBackground = $SelectedBackground


func set_passive(passive: BaseCharacterAbility) -> void:
	_passive = passive
	_passive_button.text = passive.passive_title


func to_default() -> void:
	_animat_button(0)
	_selected_background.hide()


func to_hover() -> void:
	_animat_button(0)
	_selected_background.show()
	_selected_background.unselect()


func to_press() -> void:
	_animat_button(24)
	_selected_background.show()
	_selected_background.select()


func _animat_button(left_margin: int) -> void:
	if not is_inside_tree():
		return
	if _tween:
		_tween.kill()
	_tween = get_tree().create_tween()
	_tween.tween_property(_margin_button, "theme_override_constants/margin_left", left_margin, 0.15)


func _get_tooltip_position() -> Vector2:
	return global_position + Vector2(0, size.y / 2.0)


func _on_button_mouse_entered() -> void:
	passive_selected.emit(_passive, _get_tooltip_position())
	if not _passive_button.button_pressed:
		to_hover()


func _on_button_mouse_exited() -> void:
	passive_deselected.emit(_passive, _get_tooltip_position())
	if not _passive_button.button_pressed:
		to_default()


func _on_button_toggled(toggled_on: bool) -> void:
	passive_picked.emit(_passive, _get_tooltip_position())
	if toggled_on:
		pressed.emit()
		to_press()
		return
	to_default()

