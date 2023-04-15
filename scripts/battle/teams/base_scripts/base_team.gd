class_name BaseTeam
extends Node


@export var _top_corner_hud: BaseTopCornerHUD
@export var _card_manager: CardManager

var characters: Array :
	get: return get_children()

@onready var _team_model: BaseTeamModel = BaseTeamModel.new(_top_corner_hud, _card_manager)


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
		_team_model.cancel_select_character()


func _on_character_picked(
			character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	if _team_model.is_same_choice(character, speed_dice):
		_team_model.cancel_select_character()
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
		_top_corner_hud.close()
		_card_manager.take_cards()


func _on_character_unfolded_cards(cards: Array[AbstractCard]) -> void:
	_card_manager.put_cards(cards)


func _on_character_folded_cards() -> void:
	#_card_manager.take_cards()
	pass


func _on_assault_was_set() -> void:
	_team_model.cancel_select_character()
