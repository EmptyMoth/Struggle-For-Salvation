class_name BaseTeam
extends Node


@export var _top_corner_hud: BaseTopCornerHUD
@export var _card_manager: CardManager

var characters: Array :
	get: return get_children()

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

var _team_model: BaseTeamModel = BaseTeamModel.new()


func _ready() -> void:
	CardPlacementManager.assault_was_set.connect(_on_assault_was_set)
	for character in characters:
		@warning_ignore("return_value_discarded")
		character.picked.connect(_on_character_picked)
		@warning_ignore("return_value_discarded")
		character.selected.connect(_on_character_selected)
		@warning_ignore("return_value_discarded")
		character.deselected.connect(_on_character_deselected)
		@warning_ignore("return_value_discarded")
		character.folded_cards.connect(_on_character_folded_cards)
		@warning_ignore("return_value_discarded")
		character.unfolded_cards.connect(_on_character_unfolded_cards)


func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		_cancel_select_character()


func _select_character(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	selected_character = character
	selected_speed_dice = speed_dice
	_top_corner_hud.set_character(character, speed_dice)


func _cancel_select_character() -> void:
	selected_character = null
	selected_speed_dice = null
	_top_corner_hud.close()
	_card_manager.take_cards()


func _on_character_picked(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	if selected_character == character \
			and (selected_speed_dice == speed_dice \
			or not is_instance_valid(speed_dice)):
		_cancel_select_character()
	else:
		_select_character(character, speed_dice)


func _on_character_selected(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	if is_instance_valid(selected_character):
		_top_corner_hud.set_character(character, speed_dice)
	else:
		_top_corner_hud.open(character, speed_dice)


func _on_character_deselected(
			_character: AbstractCharacter, 
			_speed_dice: AbstractSpeedDice = null) -> void:
	if is_instance_valid(selected_character):
		_top_corner_hud.set_character(selected_character, selected_speed_dice)
	else:
		_top_corner_hud.close()
		_card_manager.take_cards()


func _on_character_unfolded_cards(cards: Array[AbstractCard]) -> void:
	_card_manager.put_cards(cards)


func _on_character_folded_cards() -> void:
	#_card_manager.take_cards()
	pass


func _on_assault_was_set() -> void:
	_cancel_select_character()
