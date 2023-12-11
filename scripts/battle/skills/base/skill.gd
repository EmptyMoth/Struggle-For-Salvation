class_name Skill
extends Resource


var wearer: Character

var stats: SkillStats
var combat_model: SkillCombatModel

var use_type: AbstractSkillUseType
var is_mass_attack: bool
var targets_count: int
var actions_dice: Array[ActionDice]
var is_available: bool :
	get: return use_type.is_available()


func _init(character: Character, skill_stats: SkillStats) -> void:
	wearer = character
	stats = skill_stats
	use_type = skill_stats.use_type.create_use_type()
	is_mass_attack = stats.targeting_type is MassSkillType
	targets_count = stats.targeting_type.get_targets_count()
	actions_dice.assign(skill_stats.actions_dice_stats.map(
			func(dice_stats: ActionDiceStats): return ActionDice.new(dice_stats, self)))


func _to_string() -> String:
	return stats.title


func is_auto_set_assault() -> bool:
	return stats.targets_setter != null


func select() -> void:
	use_type.select()

func deselect() -> void:
	if combat_model == null:
		use_type.deselect()
	combat_model = null

func restore() -> void:
	use_type.restore()


func get_targets_setter() -> BaseTargetsSetter:
	return stats.targets_setter


func use() -> void:
	combat_model = SkillCombatModel.new(self)
	combat_model.skill_used.connect(use_type._on_skill_used)
	combat_model.skill_used.emit()
