class_name BaseTeamModel
extends RefCounted


func cancel_select_character() -> void:
	selected_character = null
	selected_speed_dice = null
	_top_corner_hud.close()
	_card_manager.take_cards()


func select_character(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	selected_character = character
	selected_speed_dice = speed_dice
	_top_corner_hud.set_character(character, speed_dice)
