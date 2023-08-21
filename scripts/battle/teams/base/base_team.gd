class_name BaseTeam
extends Node2D


@export_enum("allies", "enemies") var characters_group: String = "allies"

@onready var characters: Array[Node] : 
	get: return get_children()

@onready var _team_model: BaseTeamModel = BaseTeamModel.new()


func _ready() -> void:
	for character in characters:
		character.add_to_group(characters_group)
		_team_model.connect_signals(character)


func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		_team_model.deselect_character()


func set_popup_with_character_info(popup: BasePopupWithCharacterInfo) -> void:
	_team_model.popup_with_character_info = popup


func is_defeated() -> bool:
	return characters.size() < 1


func _on_assault_was_set() -> void:
	_team_model.deselect_character()
