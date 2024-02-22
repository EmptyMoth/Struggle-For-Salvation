class_name BaseSkillAbility
extends AbstractAbility


@export var _skill_condition: AbstractSkillAbilityCondition

#var _wearer_skill: Skill


func init(character: Character, skill: Skill, dice: ActionDice = null) -> void:
	_condition = _skill_condition
	super(character, skill, dice)
