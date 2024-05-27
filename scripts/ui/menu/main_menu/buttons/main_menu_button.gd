class_name MainMenuButton
extends PanelContainer


signal pressed

static var button_group: ButtonGroup = ButtonGroup.new()

@export var text: String = ""

var _tween: Tween

@onready var _main_button: Button = $Margin/Button
@onready var _margin_button: MarginContainer = $Margin
@onready var _selected_background: SelectedButtonBackground = $SelectedBackground


func _ready() -> void:
	_main_button.button_group = button_group
	_main_button.text = text


func to_default() -> void:
	_animat_button(0)
	_selected_background.hide()


func to_hover() -> void:
	_animat_button(0)
	_selected_background.show()
	_selected_background.unselect()


func to_press() -> void:
	_animat_button(_main_button.get_theme_font_size("font_size"))
	_selected_background.show()
	_selected_background.select()


func _animat_button(left_margin: int) -> void:
	if not is_inside_tree():
		return
	if _tween:
		_tween.kill()
	_tween = get_tree().create_tween()
	_tween.tween_property(_margin_button, "theme_override_constants/margin_left", left_margin, 0.15)


func _on_button_mouse_entered() -> void:
	if not _main_button.button_pressed:
		to_hover()


func _on_button_mouse_exited() -> void:
	if not _main_button.button_pressed:
		to_default()


func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		pressed.emit()
		to_press()
		return
	to_default()
