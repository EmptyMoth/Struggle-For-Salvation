extends Node


var current_battle: BaseBattle

var _selected_ally: AbstractImmunocyte
var selected_ally: AbstractImmunocyte :
	set(ally):
		_select_characted(_selected_ally, ally)
		_selected_ally = ally
	get:
		return _selected_ally

var _selected_enemy: AbstractPathogen
var selected_enemy: AbstractPathogen :
	set(enemy):
		_select_characted(_selected_enemy, enemy)
		_selected_enemy = enemy
	get:
		return _selected_enemy

var _selected_ally_speed_dice: AllySpeedDice
var selected_ally_speed_dice: AllySpeedDice :
	set(ally_speed_dice):
		_select_speed_dice(_selected_ally_speed_dice, ally_speed_dice)
		_selected_ally_speed_dice = ally_speed_dice
		if ally_speed_dice != null:
			current_battle.set_cards_in_card_manager(selected_ally.cards_deck)
	get:
		return _selected_ally_speed_dice

var _selected_enemy_speed_dice: EnemySpeedDice
var selected_enemy_speed_dice: EnemySpeedDice :
	set(enemy_speed_dice):
		_select_speed_dice(_selected_enemy_speed_dice, enemy_speed_dice)
		_selected_enemy_speed_dice = enemy_speed_dice
	get:
		return _selected_enemy_speed_dice


func view_ally_speed_dice(ally_speed_dice: AllySpeedDice) -> void:
	pass


func view_enemy_speed_dice(enemy_speed_dice: EnemySpeedDice) -> void:
	pass


func characters_place_cards_themselves(characters: Array[AbstractCharacter]) -> void:
	var independent_characters: Array[AbstractCharacter] = characters.filter(
			func(character: AbstractCharacter) -> bool: 
			return character.is_themself_placement_cards
	)
	
	var opponents_filters_by_speed_dice: Dictionary = {}
	for character in independent_characters:
		var placed_character_cards: Dictionary = character.place_cards_themself()
		opponents_filters_by_speed_dice.merge(placed_character_cards)


func _select_characted(
			old_selected_characted: AbstractCharacter,
			new_selected_characted: AbstractCharacter) -> void:
	if old_selected_characted != null:
		old_selected_characted.cancel_selected()
	
	if !_can_be_replaced(old_selected_characted, new_selected_characted):
		return
	
	new_selected_characted.make_selected()


func _select_speed_dice(
			old_selected_speed_dice: AbstractSpeedDice,
			new_selected_speed_dice: AbstractSpeedDice) -> void:
	if old_selected_speed_dice != null:
		old_selected_speed_dice.cancel_selected()
	
	if !_can_be_replaced(old_selected_speed_dice, new_selected_speed_dice):
		return
	
	new_selected_speed_dice.make_selected()


func _can_be_replaced(changeable: Node, replacement: Node) -> bool:
	return changeable != replacement and replacement != null
