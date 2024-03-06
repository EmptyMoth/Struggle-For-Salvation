@tool
class_name StopMotion
extends AbstractMotion


static var DEFAULT: StopMotion = StopMotion.new()


@export var _motion: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.DEFAULT :
	set(value):
		_motion = value
		characters_motion = value


func _init(
			_is_update_direction: bool = true,
			_characters_motion: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.DEFAULT) -> void:
	super(_is_update_direction)
	_motion = _characters_motion


func execute(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> void:
	character.view_model.switch_motion(characters_motion)
	if is_update_direction:
		character.view_model.flip_to_specified_point(main_opponent.position)
	await GlobalParameters.get_tree().create_timer(duration).timeout
