extends AbstractSettingsMenu


@onready var enemy_health: HSlider = $Settings/EnemyHealth.get_button()
@onready var enemy_damage: HSlider = $Settings/EnemyDamage.get_button()


func init() -> void:
	set_parameters(
		Settings.custom_rules_settings,
		{}
	)

