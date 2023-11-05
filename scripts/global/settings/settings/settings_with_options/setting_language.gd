class_name SettingLanguage
extends BaseSettingWithOptions


func _init() -> void:
	_options = {
		"English" = "en",
		"Русский" = "ru",
	}
	super("language", "English", _options)


func _execute() -> void:
	TranslationServer.set_locale(current_option)
