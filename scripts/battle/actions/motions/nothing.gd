class_name Nothing
extends AbstractMotion


static func _static_init() -> void:
	DEFAULT = Nothing.new()


func _init(
			_characters_motions: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.DEFAULT,
			_duration: float = 0,
			_is_update_direction: bool = false) -> void:
	pass


func execute(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> void:
	pass
