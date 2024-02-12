class_name BaseSkillAbility
extends AbstractAbility


@export var _skill_condition: AbstractSkillAbilityCondition

var _wearer_skill: Skill


func init(character: Character, skill: Skill, dice: ActionDice = null) -> void:
	_wearer_skill = skill
	_condition = _skill_condition
	super(character, skill, dice)


func _connect_condition() -> void:
	_condition.connect_condition(_effect.get("effect"), _wearer, _wearer_skill)
