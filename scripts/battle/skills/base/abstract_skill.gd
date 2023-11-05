class_name AbstractSkill
extends Resource


@export var stats: SkillStats

var wearer: Character


func _init(character: Character, skill_stats: SkillStats) -> void:
	wearer = character
	stats = skill_stats
	BattleSignals.turn_started.connect(_on_battle_turn_started)


static func create_skill(character: Character, skill_stats: SkillStats) -> AbstractSkill:
	return CooldownSkill.new(character, skill_stats) \
			if skill_stats.skill_type == SkillStats.SkillType.COOLDOWN \
			else QuantitySkill.new(character, skill_stats)


func is_mass_attack() -> bool:
	return stats.targeting_type == SkillStats.TargetingType.MASS


func is_auto_set_assault() -> bool:
	return stats.targets_setter != null


func is_available() -> bool:
	return true


func get_targets_count() -> int:
	return stats.get_targets_count()


func get_targets_setter() -> BaseTargetsSetter:
	return stats.targets_setter


func select() -> void:
	pass

func deselect() -> void:
	pass


func use() -> SkillCombatModel:
	return SkillCombatModel.new(stats)


func _on_battle_turn_started() -> void:
	pass
