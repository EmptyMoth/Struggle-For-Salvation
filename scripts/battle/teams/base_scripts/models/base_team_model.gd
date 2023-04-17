class_name BaseTeamModel
extends RefCounted


var selected_character: AbstractCharacter = null :
	set(character):
		if is_instance_valid(selected_character):
			selected_character.cancel_selected()
		
		selected_character = character
		if is_instance_valid(character):
			character.make_selected()
var selected_speed_dice: AbstractSpeedDice = null :
	set(speed_dice):
		if is_instance_valid(selected_speed_dice):
			selected_speed_dice.cancel_selected()
		
		selected_speed_dice = speed_dice
		if is_instance_valid(speed_dice):
			speed_dice.make_selected()

var top_corner_hud: BaseTopCornerHUD = null
var card_manager: CardManager = null


func _init() -> void:
	_instantiate_top_corner_hud()
	_instantiate_card_manager()


func is_selected_character_valid() -> bool:
	return is_instance_valid(selected_character)


func is_same_selected(character: AbstractCharacter, speed_dice: AbstractSpeedDice) -> bool:
	return selected_character == character \
			and (selected_speed_dice == speed_dice or not is_instance_valid(speed_dice))


func set_character_in_top_corner_hud(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	top_corner_hud.set_character(character, speed_dice)


func set_selected_character_in_top_corner_hud() -> void:
	set_character_in_top_corner_hud(selected_character, selected_speed_dice)


func select_character(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	selected_character = character
	selected_speed_dice = speed_dice
	#set_character_in_top_corner_hud(character, speed_dice)
	if not is_instance_valid(speed_dice):
		card_manager.take_cards()

func deselect_character() -> void:
	selected_character = null
	selected_speed_dice = null
	close_ui()


func close_ui() -> void:
	top_corner_hud.close()
	card_manager.take_cards()


func show_deck_of_card(cards: Array[AbstractCard]) -> void:
	card_manager.put_cards(cards)

func show_deck_of_card_selected_character() -> void:
	show_deck_of_card(selected_character.hand.cards)

func hide_deck_of_card() -> void:
	card_manager.take_cards()


func _instantiate_top_corner_hud() -> void:
	top_corner_hud = _get_top_corner_hud()

func _instantiate_card_manager() -> void:
	card_manager = _get_card_manager()


func _get_top_corner_hud() -> BaseTopCornerHUD:
	return preload("res://scenes/ui/battle_ui/characters_ui/huds/top_corner_hud/abstract_top_corner_hud.tscn").instantiate()

func _get_card_manager() -> CardManager:
	return preload("res://scenes/ui/battle_ui/cards/card_manager/card_manager.tscn").instantiate()

