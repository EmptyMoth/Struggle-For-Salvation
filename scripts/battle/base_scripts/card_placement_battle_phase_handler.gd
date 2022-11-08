class_name CardPlacementBattlePhaseHandler
extends Node


var selected_ally: AbstractCharacter
var selected_ally_speed_dice: AbstractSpeedDice
var selected_enemy: AbstractCharacter
var selected_enemy_speed_dice: AbstractSpeedDice


func  characters_place_cards_themselves(characters: Array[AbstractCharacter]) -> void:
	var independent_characters: Array[AbstractCharacter] = characters.filter(
			func(character: AbstractCharacter) -> bool: 
			return character.is_themself_placement_cards
	)
	
	var opponents_filters_by_speed_dice: Dictionary = {}
	for character in independent_characters:
		var placed_character_cards: Dictionary = character.place_cards_themself()
		opponents_filters_by_speed_dice.merge(placed_character_cards)
