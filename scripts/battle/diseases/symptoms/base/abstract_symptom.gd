class_name AbstractSymptom
extends AbstractAbility


enum EffectRecipient {
	CHARACTERS,
	ALLIES,
	ENEMIES,
	BATTLEFIELD,
}

@export var title: String
@export var effect_recipient: EffectRecipient = EffectRecipient.ALLIES
#@export var _symptom_condition: AbstractSymptomCondition

var _battle: BaseBattle


func init(character: Character= null, skill: Skill= null, dice: ActionDice= null, battle: BaseBattle = null) -> void:
	_battle = battle
	#_condition = _symptom_condition
	super(character, skill, dice)


func _to_string() -> String:
	return "%s\n%s %s" % [title, _condition.get_title(), _get_description]


func effect() -> void:
	if effect_recipient == EffectRecipient.BATTLEFIELD:
		_effect.effect()
		return
	for target: Character in _get_targets():
		_effect.effect(target)


func _get_description() -> String:
	return ""


func _get_targets() -> Array[Character]:
	match effect_recipient:
		EffectRecipient.ALLIES:
			return _battle.ally_team.characters
		EffectRecipient.ENEMIES:
			return _battle.enemy_team.characters
		_:
			return _battle.ally_team.characters + _battle.enemy_team.characters


func _connect_condition(character: Character, skill: Skill, dice: ActionDice) -> void:
	_condition.connect_condition(effect, character, skill, dice)
