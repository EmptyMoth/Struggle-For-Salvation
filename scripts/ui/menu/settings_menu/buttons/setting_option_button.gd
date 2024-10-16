class_name SettingOptionButton
extends OptionButton


static var _sound_toggled: SoundOnOff

var last_selected: int = -1


func _init() -> void:
	if _sound_toggled == null:
		_sound_toggled = SoundOnOff.new(SoundEvents.UISoundID.DROPDOWN_BUTTON_ON, SoundEvents.UISoundID.DROPDOWN_BUTTON_OFF)


func _ready() -> void:
	get_popup().transparent_bg = true


func select_item(idx: int) -> void:
	select(idx)
	_on_option_button_item_selected(idx)


func _on_option_button_item_selected(index: int) -> void:
	if last_selected >= 0:
		get_popup().set_item_disabled(last_selected, false)
	get_popup().set_item_disabled(index, true)
	last_selected = index


func _on_toggled(toggled_on: bool) -> void:
	_sound_toggled.play(toggled_on)
