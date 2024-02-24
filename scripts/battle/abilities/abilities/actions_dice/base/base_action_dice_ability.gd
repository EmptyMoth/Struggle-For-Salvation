class_name BaseDiceAbility
extends AbstractAbility


@export var _dice_condition: AbstractDiceAbilityCondition

#var _wearer: Character
#var _wearer_skill: Skill
#var _wearer_dice: ActionDice


func init(character: Character, skill: Skill, dice: ActionDice) -> void:
	_condition = _dice_condition
	super(character, skill, dice)
