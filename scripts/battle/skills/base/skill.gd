class_name Skill
extends Resource


var wearer: Character

var current_use_count: int = 0
var is_mass_attack: bool
var targets_count: int
var actions_dice: Array[ActionDice]
var is_available: bool :
	get: return stats.use_type.is_available(self)

var stats: SkillStats
var combat_model: SkillCombatModel


func _init(character: Character, skill_stats: SkillStats) -> void:
	wearer = character
	stats = skill_stats
	is_mass_attack = stats.targeting_type is MassSkillType
	targets_count = stats.targeting_type.get_targets_count()
	actions_dice.assign(skill_stats.actions_dice_stats.map(
			func(dice_stats: ActionDiceStats): return ActionDice.new(dice_stats, self)))


func _to_string() -> String:
	return stats.title


func is_auto_set_assault() -> bool:
	return stats.targets_setter != null


func select() -> void:
	stats.use_type.select(self)

func deselect() -> void:
	if combat_model == null:
		stats.use_type.deselect(self)
	combat_model = null

func restore() -> void:
	stats.use_type.restore(self)


func get_targets_setter() -> BaseTargetsSetter:
	return stats.targets_setter


func use() -> void:
	combat_model = SkillCombatModel.new(self)
	combat_model.skill_used.emit()
