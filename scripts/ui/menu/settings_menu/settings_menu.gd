class_name SettingsMenu
extends AbstractMenu


signal menu_closed

@export var _settings_content: TabContainer
@export var _first_tab_button: SettingTabButton
@export var _hebrew_label: Label

static var _sound_exit: SoundCommon
static var _sound_reset: SoundCommon


func _init() -> void:
	_sound_exit = SoundCommon.new(SoundEvents.UISoundID.BASE_BUTTON)
	_sound_reset = SoundCommon.new(SoundEvents.UISoundID.RESET_SETTINGS)


func _ready() -> void:
	_update_hebrew_text()
	open_menu()


func open_menu() -> void:
	_first_tab_button._button.button_pressed = true
	show()

func close_menu() -> void:
	hide()
	menu_closed.emit()


func _update_hebrew_text() -> void:
	_hebrew_label.text = _settings_content.get_current_tab_control().hebrew_text


func _on_save_and_exit_button_pressed() -> void:
	_sound_exit.play()
	Settings.save_settings()
	close_menu()


func _on_reset_button_pressed() -> void:
	_sound_reset.play()
	var current_settings: SettingsList = _settings_content.get_current_tab_control()
	current_settings.reset_settings()


func _on_content_tab_changed(_tab: int) -> void: _update_hebrew_text()
