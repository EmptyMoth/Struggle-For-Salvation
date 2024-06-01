class_name BaseSelectButton
extends TextureButton


const _DEFAULT_COLOR: Color = Color("C4C4C4")
const _SELECTED_COLOR: Color = Color("F5F5F5")

@export var text: String = "" :
	set(value):
		text = value
		if _label != null:
			_label.text = value

@export var _label_setting: LabelSettings

@onready var _label: Label = $Margin/Text
@onready var _margin_label: MarginContainer = $Margin


func _ready() -> void:
	_on_margin_resized()
	_label.text = text
	_label.label_settings = _label_setting


func _draw() -> void:
	match get_draw_mode():
		BaseButton.DrawMode.DRAW_NORMAL:
			to_default()
		BaseButton.DrawMode.DRAW_HOVER:
			to_hover()
		BaseButton.DrawMode.DRAW_PRESSED:
			to_press()


func to_default() -> void:
	_animat_button(0)
	_label.self_modulate = _DEFAULT_COLOR

func to_hover() -> void:
	_animat_button(0)
	_label.self_modulate = _SELECTED_COLOR

func to_press() -> void:
	_animat_button(_label_setting.font_size)
	_label.self_modulate = _SELECTED_COLOR


func _animat_button(left_margin: int) -> void:
	if left_margin == _margin_label.get_theme_constant("margin_left"):
		return
	get_tree().create_tween() \
		.tween_property(_margin_label, "theme_override_constants/margin_left", left_margin, 0.15)


func _on_margin_resized() -> void:
	custom_minimum_size.y = _margin_label.size.y
