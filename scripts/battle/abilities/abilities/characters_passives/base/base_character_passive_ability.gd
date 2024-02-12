class_name BaseCharacterAbility
extends AbstractAbility


@export var passive_title: String = ""
@export var _character_condition: AbstractCharacterAbilityCondition


func init(character: Character, skill: Skill = null, dice: ActionDice = null) -> void:
	_condition = _character_condition
	super(character, skill, dice)


func _get_description() -> String:
	return " - ".join([passive_title, _effect.get_description()])


func _connect_condition() -> void:
	_condition.connect_condition(_effect.get("effect"), _wearer)
