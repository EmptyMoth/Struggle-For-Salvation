extends AbstractSettingsMenu


func _ready() -> void:
	_settings_server = Settings.custom_rules_settings
	$Settings/EnemyHealth.set_setting(_settings_server.enemy_health)
	$Settings/EnemyDamage.set_setting(_settings_server.enemy_damage)

