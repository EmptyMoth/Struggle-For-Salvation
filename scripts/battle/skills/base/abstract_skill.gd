class_name AbstractSkill
extends Resource


@export var stats: SkillStats

var wearer: Character


func _init(character: Character, skill_stats: SkillStats) -> void:
	wearer = character
	stats = skill_stats
	BattleSignals.turn_started.connect(_on_battle_turn_started)


static func create_skill(character: Character, skill_stats: SkillStats) -> AbstractSkill:
	match skill_stats.skill_type:
		SkillStats.SkillType.COOLDOWN:
			return CooldownSkill.new(character, skill_stats)
		_:
			return QuantitySkill.new(character, skill_stats)


func is_mass_attack() -> bool:
	return stats.targeting_type == SkillStats.TargetingType.MASS


func is_auto_set_assault() -> bool:
	return stats.assault_setter != null


func is_available() -> bool:
	return true


func choose_targets_atp_slots(opponent_list: Array) -> Targets:
	@warning_ignore("static_called_on_instance")
	return stats.assault_setter.choose_targets_atp_slot(
			opponent_list, stats.get_targets_count(opponent_list.size()))


func choose_sub_targets(opponent_list: Array) -> Array[ATPSlot]:
	@warning_ignore("static_called_on_instance")
	return stats.assault_setter.choose_sub_targets(
			opponent_list, stats.get_targets_count(opponent_list.size()) - 1)


func select() -> void:
	pass

func deselect() -> void:
	pass


func use() -> SkillCombatModel:
	return SkillCombatModel.new(stats)


func _on_battle_turn_started() -> void:
	pass
