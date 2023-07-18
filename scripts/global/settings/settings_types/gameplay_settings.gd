class_name GameplaySettings
extends AbstractSettingsType


static var language := SettingLanguage.new()
static var allies_placement := SettingAlliesPlacement.new()
static var action_dice_tally := BaseSettingsWithToggle.new("action_dice_tally", false)
static var custom_rules := BaseSettingsWithToggle.new("custom_rules", false)


func _init(config: ConfigHandler) -> void:
	settings = [language, allies_placement, action_dice_tally, custom_rules]
	super("gameplay", settings, config)
