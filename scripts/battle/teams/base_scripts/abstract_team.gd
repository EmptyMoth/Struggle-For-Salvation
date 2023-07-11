class_name AbstractTeam
extends Node2D


@onready var characters: Array[Node] : 
	get: return get_children().slice(1)

@onready var _team_model: BaseTeamModel = BaseTeamModel.new()
@onready var _characters_ui: CanvasLayer = $CharactersUI


func _ready() -> void:
	_characters_ui.add_child(_team_model.top_corner_hud)
	_characters_ui.add_child(_team_model.card_manager)
	
	CardPlacementManager.assault_was_set.connect(_on_assault_was_set)
	prints(characters)
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
		_team_model.deselect_character()


func is_defeated() -> bool:
	return characters.size() < 1


func _on_character_picked(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	if _team_model.is_same_selected(character, speed_dice):
		_team_model.deselect_character()
	else:
		_team_model.select_character(character, speed_dice)


func _on_character_selected(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	_team_model.set_character_in_top_corner_hud(character, speed_dice)


func _on_character_deselected(
			_character: AbstractCharacter, 
			_speed_dice: AbstractSpeedDice = null) -> void:
	if _team_model.is_selected_character_valid():
		_team_model.set_selected_character_in_top_corner_hud()
	else:
		_team_model.close_ui()


func _on_character_unfolded_cards(cards: Array[AbstractCard]) -> void:
	_team_model.show_deck_of_card(cards)


func _on_character_folded_cards() -> void:
	if _team_model.is_selected_character_valid():
		_team_model.show_deck_of_card_selected_character()
	else:
		_team_model.hide_deck_of_card()


func _on_assault_was_set() -> void:
	_team_model.deselect_character()
