extends Node


signal assault_was_set

var _enemies_auto_assaults: Dictionary = {}
var _assaults: Dictionary = {}


func get_assaults() -> Dictionary:
	return _assaults.duplicate()


func set_assault(
			character_speed_dice: AbstractSpeedDice, 
			opponent_speed_dice: AbstractSpeedDice) -> void:
	_set_assault(character_speed_dice, opponent_speed_dice)
	emit_signal("assault_was_set")


func cancel_ally_assault(ally_speed_dice: AbstractSpeedDice) -> void:
	var opponent_speed_dice: AbstractSpeedDice = _assaults.get(ally_speed_dice)
	if not _assaults.erase(ally_speed_dice):
		return
	
	var other_character_speed_dice: AbstractSpeedDice = \
		_get_other_opponent_for_enemy(opponent_speed_dice)
	if is_instance_valid(other_character_speed_dice):
		_assaults[opponent_speed_dice] = other_character_speed_dice


func enemies_auto_selecting_cards(
			enemies: Array, opponents: Array) -> void:
	_characters_auto_selecting_cards(enemies, opponents)
	_enemies_auto_assaults = _assaults


func allies_auto_selecting_cards(
			allies: Array, opponents: Array) -> void:
	_characters_auto_selecting_cards(allies, opponents)


func _characters_auto_selecting_cards(
			characters: Array, opponents: Array) -> void:
	for character in characters:
		character.auto_place_cards()
		var assaults: Dictionary = character.auto_selecting_assault(opponents)
		_assaults.merge(assaults)
	
	emit_signal("assault_was_set")


func _set_assault(
			character_speed_dice: AbstractSpeedDice, 
			opponent_speed_dice: AbstractSpeedDice) -> void:
	if not is_instance_valid(character_speed_dice) \
			or not is_instance_valid(opponent_speed_dice):
		return
	
	_assaults[character_speed_dice] = opponent_speed_dice
	if _assaults[opponent_speed_dice] != null \
			and character_speed_dice.speed > opponent_speed_dice.speed:
		_assaults[opponent_speed_dice] = character_speed_dice


func _get_other_opponent_for_enemy(enemy_speed_dice: AbstractSpeedDice) -> AbstractSpeedDice:
	if not is_instance_valid(enemy_speed_dice):
		return null
	
	for opponent_speed_dice in _assaults:
		if _assaults[opponent_speed_dice] == enemy_speed_dice \
				and opponent_speed_dice.speed > enemy_speed_dice.speed:
			return opponent_speed_dice
	return _enemies_auto_assaults.get(enemy_speed_dice)


func _on_battle_turn_started(_turn_number: int) -> void:
	_assaults.clear()
	_enemies_auto_assaults.clear()
