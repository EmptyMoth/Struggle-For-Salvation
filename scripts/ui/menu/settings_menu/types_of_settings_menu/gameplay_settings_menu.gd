extends AbstractSettingsMenu


func _ready() -> void:
	_settings_server = Settings.gameplay_settings
	$Settings/Language.set_setting(_settings_server.language)
	$Settings/AlliesPlacement.set_setting(_settings_server.allies_placement)
	$Settings/ActionDiceTally.set_setting(_settings_server.action_dice_tally)
	$Settings/CustomRules.set_setting(_settings_server.custom_rules)
