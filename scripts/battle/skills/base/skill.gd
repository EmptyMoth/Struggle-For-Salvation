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
	targets_count = stats.targets_count
	is_mass_attack = stats.targets_count > 1
	actions_dice.assign(skill_stats.actions_dice_stats.map(
			func(dice_stats: ActionDiceStats) -> ActionDice: return ActionDice.new(dice_stats, self)))
	for ability: BaseSkillAbility in stats.abilities:
		ability.init(wearer, self)


func _to_string() -> String:
	return stats.title


func is_auto_set_assault() -> bool:
	return stats.targets_setter != null


func restore() -> void: use_type.restore()

func select() -> void: use_type.select()

func deselect() -> void: use_type.deselect()


func get_targets_setter() -> BaseTargetsSetter:
	return stats.targets_setter


func use() -> void:
	combat_model = SkillCombatModel.new(self)
	use_type._on_skill_used()


func _on_battle_turn_started() -> void:
	combat_model = null
