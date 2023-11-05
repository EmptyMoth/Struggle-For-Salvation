class_name BaseTeam
extends Node2D


@export var team_fraction: BattleEnums.Fraction
@export var _characters_parameters: Array[CharacterBattleParameters] = []

@onready var characters: Array[Node] :
	get: return BattleGroups.get_fraction_group(team_fraction)

@onready var _team_ui := TeamUI.new()


func _ready() -> void:
	_team_ui.connect_signals(team_fraction)
	for character_parameter in _characters_parameters:
		add_child(Character.new(character_parameter, team_fraction))


func set_popup_with_character_info(popup: BasePopupWithCharacterInfo) -> void:
	_team_ui.popup_with_character_info = popup


func is_defeated() -> bool:
	return characters.size() < 1
