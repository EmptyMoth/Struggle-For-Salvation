class_name Nothing
extends AbstractMotion


static var DEFAULT: Nothing = Nothing.new()


func _init(
			_characters_motions: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.DEFAULT,
			_is_update_direction: bool = false,
			_duration: float = 0) -> void:
	pass


func execute(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> void:
	pass
