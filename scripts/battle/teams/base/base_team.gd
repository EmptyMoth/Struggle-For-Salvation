class_name BaseTeam
extends Node2D


@export var team_fraction: BattleEnums.Fraction
@export var _characters_parameters: Array[CharacterBattleParameters] = []

@onready var characters: Array[Character] :
	get: return BattleGroups.get_fraction_group(team_fraction)

@onready var _team_ui := TeamUI.new()


func _ready() -> void:
	for character_parameter: CharacterBattleParameters in _characters_parameters:
		var character: Character = character_parameter.character.instantiate()
		character.init(character_parameter.stats, self)
		add_child(character)


func set_team_ui(popup: PopupWithCharacterInfo, tooltip: TooltipSkillsSet) -> void:
	_team_ui.set_team_ui(popup, tooltip)
	_team_ui.connect_signals(team_fraction)


func is_defeated() -> bool:
	for character: Character in characters:
		if not character.is_dead:
			return false
	return true
