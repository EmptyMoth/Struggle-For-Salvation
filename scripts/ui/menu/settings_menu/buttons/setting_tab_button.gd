class_name SettingTabButton
extends PanelContainer


@export var title: String = ""

@export_group("Conections")
@export var _button: Button
@export var _background: TextureRect
@export var _selected_marker: VBoxContainer

static var _sound: SoundCommon


func _init() -> void:
	if _sound == null:
		_sound = SoundCommon.new(SoundEvents.UISoundID.SETTINGS_TAB_BUTTON)


func _ready() -> void:
	$Margin/Title.text = title


func set_button_group(button_group: ButtonGroup) -> void:
	_button.button_group = button_group


func _on_button_draw() -> void:
	var draw_mode: BaseButton.DrawMode = _button.get_draw_mode()
	var is_pressed: bool = draw_mode == _button.DRAW_PRESSED or  draw_mode == _button.DRAW_HOVER_PRESSED
	_background.modulate = Color("33AAFF" if is_pressed else "F5F5F5", _background.modulate.a)
	_selected_marker.visible = is_pressed
	
	create_tween().tween_property(_background, "modulate:a", 0 if draw_mode == _button.DRAW_NORMAL else 1, 0.25)


func _on_button_pressed() -> void:
	_sound.play()
