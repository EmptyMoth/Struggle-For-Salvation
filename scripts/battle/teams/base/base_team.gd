class_name BaseTeam
extends Node2D


@export var team_fraction: BattleEnums.Fraction
@export var _characters_parameters: Array[CharacterBattleParameters] = []

@onready var characters: Array[Node] :
	get: return get_tree().get_nodes_in_group(
			BattleParameters.CHARACTERS_GROUPS_BY_FRACTIONS[team_fraction])

@onready var _team_ui := TeamUI.new()


func _ready() -> void:
	for character_parameter in _characters_parameters:
		var character: Character = Character.new(character_parameter, team_fraction)
		add_child(character)
		_team_ui.connect_signals(character.get_view())


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		_team_ui.close_ui()


func set_popup_with_character_info(popup: BasePopupWithCharacterInfo) -> void:
	_team_ui.popup_with_character_info = popup


func is_defeated() -> bool:
	return characters.size() < 1
