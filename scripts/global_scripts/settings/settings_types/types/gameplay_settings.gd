class_name GameplaySettings
extends AbstractSettings


const LANGUAGE_DEFAULT: String = "English"
const LANGUAGE: Dictionary = {
	"English" = "en",
	"Русский" = "ru",
}

const LOCATION_OF_ALLIES_ON_BATTLEFIELD_DEFAULT: String = "Left"
const LOCATION_OF_ALLIES_ON_BATTLEFIELD: Dictionary =  {
	"Left" = true,
	"Right" = false,
}

var language := LANGUAGE_DEFAULT :
	set(value):
		language = value
		var locale: String = LANGUAGE[language]
		TranslationServer.set_locale(locale)
		_save_change_setting("language", language)
var location_of_allies_on_battlefield := LOCATION_OF_ALLIES_ON_BATTLEFIELD_DEFAULT :
	set(value):
		location_of_allies_on_battlefield = value
		_save_change_setting("location_of_allies_on_battlefield", location_of_allies_on_battlefield)
var whether_to_count_action_dice: bool = false :
	set(value):
		whether_to_count_action_dice = value
		_save_change_setting("whether_to_count_action_dice", whether_to_count_action_dice)
var custom_rules: bool = false :
	set(value):
		custom_rules = value
		_save_change_setting("custom_rules", custom_rules)


func _init(config: ConfigHandler) -> void:
	super(config, "gameplay")


func is_location_of_allies_on_left_battlefield() -> bool:
	return LOCATION_OF_ALLIES_ON_BATTLEFIELD[location_of_allies_on_battlefield]
