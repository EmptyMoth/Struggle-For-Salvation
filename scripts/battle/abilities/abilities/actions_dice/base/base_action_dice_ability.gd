class_name BaseDiceAbility
extends AbstractAbility


@export var _dice_condition: AbstractDiceAbilityCondition

var _wearer_skill: Skill
var _wearer_dice: ActionDice


func init(character: Character, skill: Skill, dice: ActionDice) -> void:
	_wearer_dice = dice
	_wearer_skill = skill
	_condition = _dice_condition
	super(character, skill, dice)


func _connect_condition() -> void:
	_condition.connect_condition(_effect.get("effect"), _wearer, _wearer_skill, _wearer_dice)
