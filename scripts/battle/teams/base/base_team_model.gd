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

var popup_with_character_info: BasePopupWithCharacterInfo = null


func is_character_selected() -> bool:
	return is_instance_valid(selected_character)


func is_same_selected(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> bool:
	return selected_character == character \
			and (selected_speed_dice == speed_dice or speed_dice == null)


func set_character_info(character: AbstractCharacter, speed_dice: AbstractSpeedDice) -> void:
	popup_with_character_info.set_info(character, speed_dice)


func set_selected_character_info() -> void:
	set_character_info(selected_character, selected_speed_dice)


func select_character(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	selected_character = character
	selected_speed_dice = speed_dice


func deselect_character() -> void:
	selected_character = null
	selected_speed_dice = null
	close_ui()


func close_ui() -> void:
	popup_with_character_info.close()


func connect_signals(character: AbstractCharacter) -> void:
	@warning_ignore("return_value_discarded")
	character.picked.connect(_on_character_picked)
	@warning_ignore("return_value_discarded")
	character.selected.connect(_on_character_selected)
	@warning_ignore("return_value_discarded")
	character.deselected.connect(_on_character_deselected)


func _on_character_picked(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	if is_same_selected(character, speed_dice):
		deselect_character()
	else:
		select_character(character, speed_dice)


func _on_character_selected(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	set_character_info(character, speed_dice)


func _on_character_deselected(
			_character: AbstractCharacter, 
			_speed_dice: AbstractSpeedDice = null) -> void:
	if is_character_selected():
		set_selected_character_info()
	else:
		close_ui()
