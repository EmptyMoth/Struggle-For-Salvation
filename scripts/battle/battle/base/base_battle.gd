class_name BaseBattle
extends Node2D


const _POPUP_WITH_ASSAULT_INFO_SCENE: PackedScene = preload("res://scenes/ui/battle/popup_with_assault/base_popup_with_assault_info.tscn")

@export var disease: BaseDisease

@export var _packed_formation: PackedScene
@export var _packed_location: PackedScene

static var battle: BaseBattle

var turn_number: int = 0
var current_phase: BattleEnums.BattlePhase = BattleEnums.BattlePhase.PREPARATION

var _location: BaseLocation = null
var _battlefield: BaseBattlefield = null

@onready var ally_team: BaseTeam = $Teams/AllyTeam
@onready var enemy_team: BaseTeam = $Teams/EnemyTeam

@onready var _assaults_arrows: Control = $EnvironmentUI/AssaultsArrows
@onready var _popups_with_assault_info: Control = $EnvironmentUI/PopupsWithAssaultInfo


func _ready() -> void:
	BaseBattle.battle = self
	_init_of_teams()
	set_location(_packed_location.instantiate())
	_connect_signals()
	add_assault_arrow($Managers/PreparationPhaseManager/PlayerArrangeAssaults._player_assault_arrow)
	BattleSignals.battle_started.emit()


func _input(_event: InputEvent) -> void:
	if current_phase != BattleEnums.BattlePhase.PREPARATION:
		return
	
	if Input.is_action_just_released("ui_switch_battle_phase"):
		PreparationPhaseManager.finish_phase()
		return
	
	if Input.is_action_just_released("ui_auto_set_assault"):
		AutoArrangeAssaults.arranges_allies()
	
	if Input.is_action_just_released("ui_show_one_side_allied_arrows"):
		BattleSettings.toggle_display_allied_arrows()
	elif Input.is_action_just_released("ui_show_one_side_enemy_arrows"):
		BattleSettings.toggle_display_enemy_arrows()
	elif Input.is_action_just_released("ui_show_clashing_arrows"):
		BattleSettings.toggle_display_clashing_arrows()


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_cancel"):
		PlayerInputManager.player_made_general_cancel.emit()


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
	_assaults_arrows.add_child(arrow)

func remove_assault_arrow(arrow: BaseAssaultArrow) -> void:
	_assaults_arrows.remove_child(arrow)


func victory() -> void:
	print("IS VICTORY!")
	$CanvasUI/EndScreen/Victory.show()
	end()

func defeate() -> void:
	print("IS DEFEATE!")
	$CanvasUI/EndScreen/Defeat.show()
	end()

func end() -> void:
	#BattleSignals.battle_ended.emit()
	#battle = null
	var end_screen: Control = $CanvasUI/EndScreen
	get_tree().create_tween().tween_property(end_screen, "modulate:a", 1.0, 0.7).from(0.0)
	end_screen.show()


func highlight_characters(is_highlight: bool) -> void:
	_location.darken(not is_highlight)


func _start_next_turn() -> void:
	turn_number += 1
	BattleSignals.turn_started.emit()


func _add_popup_with_assault_info(character: Character, is_left: bool) -> void:
	var popup: PopupWithAssaultInfo = _POPUP_WITH_ASSAULT_INFO_SCENE.instantiate()
	popup.is_left = is_left
	_popups_with_assault_info.add_child(popup)
	popup.set_info(character)


func _init_of_teams() -> void:
	var left_popup: PopupWithCharacterInfo = $CanvasUI/PopupsCharacterInfo/HBox/Left
	var right_popup: PopupWithCharacterInfo = $CanvasUI/PopupsCharacterInfo/HBox/Right
	ally_team.set_popup_with_character_info(
			left_popup if Settings.gameplay_settings.allies_placement.is_left else right_popup)
	enemy_team.set_popup_with_character_info(
			left_popup if not Settings.gameplay_settings.allies_placement.is_left else right_popup)


func _connect_signals() -> void:
	BattleSignals.preparation_started.connect(_on_preparation_started)
	BattleSignals.combat_started.connect(_on_combat_started)
	BattleSignals.combat_ended.connect(_on_combat_ended)
	BattleSignals.battle_started.connect(_start_next_turn)
	BattleSignals.turn_ended.connect(_start_next_turn)
	
	BattleSignals.assault_started.connect(_on_assault_started)
	BattleSignals.assault_ended.connect(_on_assault_ended)
	BattleSignals.one_side_started.connect(_on_one_side_started)
	BattleSignals.clash_started.connect(_on_clash_started)


func _on_preparation_started() -> void:
	current_phase = BattleEnums.BattlePhase.PREPARATION

func _on_combat_started() -> void:
	current_phase = BattleEnums.BattlePhase.COMBAT


func _on_combat_ended() -> void:
	if enemy_team.is_defeated():
		victory()
	elif ally_team.is_defeated():
		defeate()
	else:
		BattleSignals.turn_ended.emit()


func _on_assault_started(character: Character, target: Character) -> void:
	highlight_characters(true)

func _on_assault_ended(character: Character, target: Character) -> void:
	highlight_characters(false)
	for popup: Node in _popups_with_assault_info.get_children():
		popup.queue_free()


func _on_one_side_started(character: Character, target: Character) -> void:
	var is_left: bool = character.movement_model.to_left_of(target)
	_add_popup_with_assault_info(character, is_left)


func _on_clash_started(opponent_1: Character, opponent_2: Character) -> void:
	var is_left_1: bool = opponent_1.movement_model.to_left_of(opponent_2)
	_add_popup_with_assault_info(opponent_1, is_left_1)
	_add_popup_with_assault_info(opponent_2, not is_left_1)
