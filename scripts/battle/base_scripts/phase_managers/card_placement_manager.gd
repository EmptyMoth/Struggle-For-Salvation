extends Node


var _selected_ally: AbstractCharacter
var selected_ally: AbstractCharacter :
	set(ally):
		if _selected_ally != null:
			_selected_ally.cancel_selected()
		
		if ally == null \
				or _selected_ally == ally:
			return
		
		ally.make_selected()
		_selected_ally = ally
	get:
		return _selected_ally

var _selected_enemy: AbstractCharacter
var selected_enemy: AbstractCharacter :
	set(enemy):
		if _selected_enemy != null:
			_selected_enemy.cancel_selected()
			
		if enemy == null \
				or _selected_enemy == enemy:
			return
		
		enemy.make_selected()
		_selected_enemy = enemy
	get:
		return _selected_enemy

var _selected_ally_speed_dice: AllySpeedDice
var selected_ally_speed_dice: AllySpeedDice :
	set(ally_speed_dice):
		if _selected_ally_speed_dice != null:
			_selected_ally_speed_dice.cancel_selected()
			
		if ally_speed_dice == null \
				or _selected_ally_speed_dice == ally_speed_dice:
			return
		
		ally_speed_dice.make_selected()
		_selected_ally_speed_dice = ally_speed_dice
	get:
		return _selected_ally_speed_dice

var _selected_enemy_speed_dice: EnemySpeedDice
var selected_enemy_speed_dice: EnemySpeedDice :
	set(enemy_speed_dice):
		if _selected_enemy_speed_dice != null:
			_selected_enemy_speed_dice.cancel_selected()
			
		if enemy_speed_dice == null \
				or _selected_enemy_speed_dice == enemy_speed_dice:
			return
		
		enemy_speed_dice.make_selected()
		_selected_enemy_speed_dice = enemy_speed_dice
	get:
		return _selected_enemy_speed_dice


func view_ally_speed_dice(ally_speed_dice: AllySpeedDice) -> void:
	pass


func view_enemy_speed_dice(enemy_speed_dice: EnemySpeedDice) -> void:
	pass


func select_ally_speed_dice(ally_speed_dice: AllySpeedDice) -> void:
	selected_ally_speed_dice = ally_speed_dice


func characters_place_cards_themselves(characters: Array[AbstractCharacter]) -> void:
	var independent_characters: Array[AbstractCharacter] = characters.filter(
			func(character: AbstractCharacter) -> bool: 
			return character.is_themself_placement_cards
	)
	
	var opponents_filters_by_speed_dice: Dictionary = {}
	for character in independent_characters:
		var placed_character_cards: Dictionary = character.place_cards_themself()
		opponents_filters_by_speed_dice.merge(placed_character_cards)
