extends AbstractSettingsMenu


@onready var language: OptionButton = $Settings/Language.get_button()
@onready var location_of_allies_on_battlefield: OptionButton = \
	$Settings/LocationOfAllyTeamOnBattlefield.get_button()
@onready var whether_to_count_action_dice: CheckButton = \
	$Settings/WhetherToCountActionDice.get_button()
@onready var custom_rules: CheckButton = $Settings/CustomRules.get_button()


func init() -> void:
	set_parameters(
		Settings.gameplay_settings,
		{
			"language" = GameplaySettings.LANGUAGE.keys(),
			"location_of_allies_on_battlefield" = \
				GameplaySettings.LOCATION_OF_ALLIES_ON_BATTLEFIELD.keys()
		}
	)
