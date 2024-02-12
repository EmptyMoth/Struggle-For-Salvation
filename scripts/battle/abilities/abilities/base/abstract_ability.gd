class_name AbstractAbility
extends Resource


@export var _effect: AbstractAbilityEffect

var description: String = ""

var _wearer: Character
var _condition: AbstractAbilityCondition


func init(character: Character, skill: Skill, dice: ActionDice) -> void:
	_wearer = character
	_effect._wearer = character
	_connect_condition()
	description = _get_description()


static func get_abilities_description(abilities: Array, presset: String = "%s") -> String:
	var descriptions: PackedStringArray = PackedStringArray()
	for ability: AbstractAbility in abilities:
		descriptions.append(presset % ability.description)
	return "\n".join(descriptions)


func _connect_condition() -> void: pass


func _get_description() -> String:
	return " ".join([_condition.get_title(), _effect.get_description()])
