@tool
class_name DefaultAttackMotion
extends AbstractMotion


@export_enum(
	"1:%s" % BattleEnums.CharactersMotions.ATTACK_1,
	"2:%s" % BattleEnums.CharactersMotions.ATTACK_2,
	"3:%s" % BattleEnums.CharactersMotions.ATTACK_3,
	"4:%s" % BattleEnums.CharactersMotions.ATTACK_4,
	"5:%s" % BattleEnums.CharactersMotions.ATTACK_5,
	"6:%s" % BattleEnums.CharactersMotions.ATTACK_6,
	"7:%s" % BattleEnums.CharactersMotions.ATTACK_7,
	"8:%s" % BattleEnums.CharactersMotions.ATTACK_8,
	"9:%s" % BattleEnums.CharactersMotions.ATTACK_9,
) var _attack: int :
	set(value):
		_attack = value
		characters_motion = value


func _init(
			_characters_motion: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.ATTACK_1,
			_is_update_direction: bool = true) -> void:
	super(_is_update_direction)
	_attack = _characters_motion


func _create_additional_position(character: Character, main_opponent: Character, _sub_targets: Array[Character] = []) -> Vector3:
	var moving_character: CharacterMovementModel = character.movement_model
	var new_position: Vector3 = main_opponent.movement_model.position - moving_character.position
	new_position = new_position.normalized() / 3
	return new_position
