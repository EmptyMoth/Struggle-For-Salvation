class_name BaseBattle
extends Node2D


@export var _packed_formation: PackedScene
@export var _packed_location: PackedScene

var turn_number: int = 0
var current_phase: BattleEnums.BattlePhase = BattleEnums.BattlePhase.PREPARATION

var _location: BaseLocation = null
var _battlefield: BaseBattlefield = null

@onready var ally_team: BaseTeam = $Teams/AllyTeam
@onready var enemy_team: BaseTeam = $Teams/EnemyTeam
@onready var pause_menu: Control = $CanvasLayer/PauseMenu
@onready var assaults_arrows: Control = $AssaultsArrows
@onready var _darkening_screen: ColorRect = $UI/DarkeningScreen


func _ready() -> void:
	BattleParameters.battle = self
	_init_of_teams()
	set_location(_packed_location.instantiate())
	BattleSignals.turn_started.connect(_on_turn_started)
	BattleSignals.turn_ended.connect(_on_turn_ended)
	BattleSignals.combat_started.connect(_implements_combat_phase)
	BattleSignals.battle_started.emit()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_menu") and !pause_menu.just_closed:
		pause_menu.pause_game()
	pause_menu.just_closed = false

	if current_phase == BattleEnums.BattlePhase.PREPARATION:
		if Input.is_action_just_released("ui_switch_battle_phase"):
			pass
		if Input.is_action_just_released("ui_auto_set_assault"):
			AutoArrangeAssaults.arranges_allies	()


func set_location(location: BaseLocation) -> void:
	_location = location
	add_child(_location)
	move_child(_location, 0)
	set_battlefild(_location.battlefield)


func set_battlefild(battlefield: BaseBattlefield) -> void:
	_battlefield = battlefield
	_battlefield.set_characters_markers_on_battlefield(
			ally_team.characters, enemy_team.characters)
	_battlefield.set_formation(_packed_formation.instantiate(),
			ally_team.characters, enemy_team.characters)


func add_assault_arrow(arrow: BaseAssaultArrow) -> void:
	assaults_arrows.add_child(arrow)

func remove_assault_arrow(arrow: BaseAssaultArrow) -> void:
	assaults_arrows.remove_child(arrow)


func victory() -> void:
	end()

func defeate() -> void:
	end()

func end() -> void:
	pass


func _implements_card_placement_phase() -> void:
	current_phase = BattleEnums.BattlePhase.PREPARATION
	get_tree().call_group("characters", "prepare_for_card_placement")


func _implements_combat_phase() -> void:
	current_phase = BattleEnums.BattlePhase.COMBAT
	BattleSignals.combat_started.emit()
	get_tree().call_group("characters", "prepare_for_combat")


func highlight_nodes(nodes: Array[CanvasItem], is_highlight: bool) -> void:
	_darkening_screen.visible = is_highlight
	for node in nodes:
		node.z_index = 1 if is_highlight else 0


func _on_turn_started() -> void:
	turn_number += 1


func _on_turn_ended() -> void:
	if enemy_team.is_defeated():
		victory()
	elif ally_team.is_defeated():
		defeate()
	BattleSignals.turn_ended.emit(turn_number)


func _init_of_teams() -> void:
	var left_popup: BasePopupWithCharacterInfo = $UI/PopupsWithCharacterInfo/Left
	var right_popup: BasePopupWithCharacterInfo = $UI/PopupsWithCharacterInfo/Right
	ally_team.set_popup_with_character_info(
			left_popup if Settings.gameplay_settings.allies_placement.is_left else right_popup)
	enemy_team.set_popup_with_character_info(
			left_popup if not Settings.gameplay_settings.allies_placement.is_left else right_popup)
