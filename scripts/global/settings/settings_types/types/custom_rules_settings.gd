class_name CustomRulesSettings
extends AbstractSettingsType


static var enemy_health := BaseSettingWithRange.new("enemy_health", 1.0, 0.5, 2.0, 0.5)
static var enemy_damage := BaseSettingWithRange.new("enemy_damage", 1.0, 0.5, 2.0, 0.5)


func _init(config: ConfigHandler) -> void:
	settings = [enemy_health, enemy_damage]
	super("custom_rules", settings, config)
