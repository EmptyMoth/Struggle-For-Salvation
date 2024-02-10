class_name AbstractStatusEffect
extends Resource


signal expired(effect: AbstractStatusEffect)

var wearer: Character

var is_reduced_in_end_turn: bool = true


func _init(character: Character) -> void:
	wearer = character
	_get_condition().connect(implement)


static func get_tag() -> StatusEffectsList.Tags:
	return StatusEffectsList.Tags.TEST_EFFECT


static func get_keyword() -> String:
	return "TestWord"


static func get_icon_path() -> String:
	return ""


static func get_icon() -> Texture2D:
	return Texture2D.new()


func implement() -> void:
	pass


func reduce() -> void:
	pass


func _get_condition() -> Signal:
	return BattleSignals.turn_ended
