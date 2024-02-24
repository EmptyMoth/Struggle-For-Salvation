class_name AbstractAbility
extends Resource


@export var _effect: AbstractAbilityEffect

var _condition: AbstractAbilityCondition


func init(character: Character, skill: Skill, dice: ActionDice) -> void:
	_connect_condition(character, skill, dice)


func _to_string() -> String:
	return _get_description()


static func get_abilities_description(abilities: Array, presset: String = "%s") -> String:
	var descriptions: PackedStringArray = PackedStringArray()
	for ability: AbstractAbility in abilities:
		descriptions.append(presset % str(ability))
	return "\n".join(descriptions)


func _connect_condition(character: Character, skill: Skill, dice: ActionDice) -> void:
	var effect: Callable = _effect.effect.bindv([character, skill, dice])
	_condition.connect_condition(effect, character, skill, dice)


func _get_description() -> String:
	return " ".join([_condition.get_title(), _effect.get_description()])
