@tool
class_name NothingMotion
extends AbstractMotion


static var DEFAULT: NothingMotion = NothingMotion.new()


func _init(_is_update_direction: bool = false) -> void: pass


func execute(character: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> void: pass
