@tool
class_name SettingCheckBox
extends Button


static var _sound_toggled: SoundOnOff

@onready var _cross_texture: TextureRect = $CenterContainer/Cross


func _init() -> void:
	if _sound_toggled == null:
		_sound_toggled = SoundOnOff.new(SoundEvents.UISoundID.CHECK_BUTTON_ON, SoundEvents.UISoundID.CHECK_BUTTON_OFF)


func _ready() -> void:
	_on_toggled(button_pressed)


func _draw() -> void:
	_cross_texture.visible = get_draw_mode() != DRAW_NORMAL or button_pressed


func set_pressed_without_signal(is_press: bool) -> void:
	set_pressed_no_signal(is_press)
	_on_toggled(is_press)


func _on_toggled(toggled_on: bool) -> void:
	_sound_toggled.play(toggled_on)
	var final_size: Vector2 = Vector2.ONE * (52 if toggled_on else 16)
	create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE) \
		.tween_property(_cross_texture, "custom_minimum_size", final_size, 0.25)
