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


var _top_corner_hud: BaseTopCornerHUD = null
var _card_manager: CardManager = null


func _init(top_corner_hud: BaseTopCornerHUD, card_manager: CardManager) -> void:
	_top_corner_hud = top_corner_hud
	_card_manager = card_manager


func select_character(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	selected_character = character
	selected_speed_dice = speed_dice
	set_character_in_top_corner_hud(character, speed_dice)


func cancel_select_character() -> void:
	selected_character = null
	selected_speed_dice = null
	_top_corner_hud.close()
	_card_manager.take_cards()


func set_character_in_top_corner_hud(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	_top_corner_hud.set_character(character, speed_dice)


func set_selected_character_in_top_corner_hud() -> void:
	set_character_in_top_corner_hud(selected_character, selected_speed_dice)


func is_selected_character_valid() -> bool:
	return is_instance_valid(selected_character)


func is_same_choice(character: AbstractCharacter, speed_dice: AbstractSpeedDice) -> bool:
	return selected_character == character \
			and (selected_speed_dice == speed_dice or not is_instance_valid(speed_dice))
