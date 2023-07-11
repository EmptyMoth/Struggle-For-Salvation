extends Node


signal combat_end

var _opponents_by_speed_dice: Dictionary = {}
var _assaults_type_by_speed_dice: Dictionary = {}


func set_assaults(assaults: Dictionary) -> void:
	_opponents_by_speed_dice = assaults
	for character_speed_dice in assaults:
		var opponent_speed_dice: AbstractSpeedDice = assaults[character_speed_dice]
		_assaults_type_by_speed_dice[character_speed_dice] = (
			BattleParameters.AssaultType.CLASH
			if assaults.get(opponent_speed_dice) == character_speed_dice 
			else BattleParameters.AssaultType.ONE_SIDE
		)


func activate_assaults() -> void:
	var characters_speed_dice = _opponents_by_speed_dice.keys()
	characters_speed_dice.sort_custom(sort_speed_dice_descending)
	for character_speed_dice in characters_speed_dice:
		var opponent_speed_dice: AbstractSpeedDice = _opponents_by_speed_dice[character_speed_dice]
		match _assaults_type_by_speed_dice[character_speed_dice]:
			BattleParameters.AssaultType.ONE_SIDE:
				_activate_one_side_attack(character_speed_dice, opponent_speed_dice)
			BattleParameters.AssaultType.CLASH:
				_activate_clash(character_speed_dice, opponent_speed_dice)
		await get_tree().create_timer(1).timeout
	
	emit_signal("combat_end")


func _activate_one_side_attack(
		character_speed_dice: AbstractSpeedDice, opponent_speed_dice: AbstractSpeedDice) -> void:
	var character: AbstractCharacter = character_speed_dice.get_character()
	var opponent: AbstractCharacter = opponent_speed_dice.get_character()
	character.move_to_assault(opponent.get_character_marker_position())


func _activate_clash(
		character_speed_dice: AbstractSpeedDice, opponent_speed_dice: AbstractSpeedDice) -> void:
	var character: AbstractCharacter = character_speed_dice.get_character()
	var opponent: AbstractCharacter = opponent_speed_dice.get_character()
	var new_position = (character.get_character_marker_position() - opponent.get_character_marker_position()) / 2
	character.move_to_assault(new_position)
	opponent.move_to_assault(new_position)


func sort_speed_dice_descending(
		speed_dice_1: AbstractSpeedDice, speed_dice_2: AbstractSpeedDice) -> bool:
	var assault_weight_1: int = _get_assault_weight(speed_dice_1)
	var assault_weight_2: int = _get_assault_weight(speed_dice_2)
	return assault_weight_1 > assault_weight_2

func _get_assault_weight(speed_dice: AbstractSpeedDice) -> int:
	return AbstractSpeedDice.calculate_assault_weight(
		speed_dice, 
		_opponents_by_speed_dice[speed_dice], 
		_assaults_type_by_speed_dice[speed_dice]
	)
