extends AbstractSettingsMenu


@onready var language: OptionButton = $Settings/Language.get_button()
@onready var allies_placement: OptionButton = $Settings/AlliesPlacement.get_button()
@onready var action_dice_tally: CheckButton = $Settings/ActionDiceTally.get_button()
@onready var custom_rules: CheckButton = $Settings/CustomRules.get_button()


func init() -> void:
	set_parameters(
		Settings.gameplay_settings,
		{
			"language" = GameplaySettings.language.get_options().keys(),
			"allies_placement" = GameplaySettings.allies_placement.get_options().keys()
		}
	)
