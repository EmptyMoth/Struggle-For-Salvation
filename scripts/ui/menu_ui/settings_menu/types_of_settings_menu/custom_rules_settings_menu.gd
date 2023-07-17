extends AbstractSettingsMenu


func _ready() -> void:
	_settings_server = Settings.custom_rules_settings
	$Settings/EnemyHealth.set_setting(_settings_server.enemy_health)
	$Settings/EnemyDamage.set_setting(_settings_server.enemy_damage)
	var custom_rules: BaseSettingsWithToggle = Settings.gameplay_settings.custom_rules
	custom_rules.setting_changed.connect(_on_custom_rules_changed)
	_on_custom_rules_changed(custom_rules.is_on)


func _on_custom_rules_changed(new_value: bool) -> void:
	for setting_element in $Settings.get_children():
		if not setting_element is BaseSettingElementMenu:
			continue
		var setting_button: Control = setting_element.get_setting_button()
		if setting_button is HSlider:
			setting_button.editable = new_value
		elif setting_button is BaseButton:
			setting_button.disabled = new_value
