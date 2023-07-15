class_name CustomRulesSettings
extends AbstractSettings


var enemy_health: float = 1.0 :
	set(value):
		enemy_health = value
		_save_change_setting("enemy_health", enemy_health)
var enemy_damage: float = 1.0 :
	set(value):
		enemy_damage = value
		_save_change_setting("enemy_damage", enemy_damage)


func _init(config: ConfigHandler) -> void:
	super(config, "custom_rules")
