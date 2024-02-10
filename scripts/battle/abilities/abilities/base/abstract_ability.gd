class_name AbstractAbility
extends Resource


@export var _effect: AbstractAbilityEffect

var description: String = ""

var _condition: AbstractAbilityCondition
var _wearer: Character


func init(wearer: Character) -> void:
	_wearer = wearer
	_effect._wearer = wearer
	_condition = _create_condition(get("_condition_title"))
	_condition.connect_condition(_wearer, _effect.get("effect"))
	description = _get_description()


static func get_abilities_description(abilities: Array, presset: String = "%s") -> String:
	var descriptions: PackedStringArray = PackedStringArray()
	for ability: AbstractAbility in abilities:
		descriptions.append(presset % ability.description)
	return "\n".join(descriptions)


static func _create_condition(condition_title: String) -> AbstractAbilityCondition:
	condition_title = condition_title.to_snake_case()
	return load("res://scripts/battle/abilities/conditions/%s.gd" % condition_title).new()


func _get_description() -> String:
	return " ".join([_condition.get_title(), _effect.get_description()])
