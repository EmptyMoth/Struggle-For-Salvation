class_name BaseBattle
extends Node2D


signal turn_started(turn_number: int)
signal turn_ended
signal combat_started

enum BattlePhase { CARD_PLACEMENT, COMBAT }

@export var _packed_formation: PackedScene
@export var _packed_location: PackedScene

var turn_number: int = 0
var current_phase: BattlePhase = BattlePhase.COMBAT

var _location: BaseLocation = null
var _battlefield: BaseBattlefield = null

@onready var ally_team: BaseTeam = $Teams/AllyTeam
@onready var enemy_team: BaseTeam = $Teams/EnemyTeam
@onready var pause_menu: Control = $CanvasLayer/PauseMenu


func _ready() -> void:
	set_location(_packed_location.instantiate())
	_init_of_teams()
	_connect_signals()
	_switch_battle_phase()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_menu") and !pause_menu.just_closed:
		pause_menu.pause_game()
	pause_menu.just_closed = false
	
	if current_phase == BattlePhase.CARD_PLACEMENT:
		if Input.is_action_just_released("ui_switch_battle_phase"):
			_switch_battle_phase()
		if Input.is_action_just_released("ui_auto_selecting_cards"):
			CardPlacementManager.allies_auto_selecting_cards(ally_team.characters, enemy_team.characters)


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


func victory() -> void:
	end()

func defeate() -> void:
	end()

func end() -> void:
	pass


func _switch_battle_phase() -> void:
	match current_phase:
		BattlePhase.COMBAT:
			_start_turn()
			_implements_card_placement_phase()
		BattlePhase.CARD_PLACEMENT:
			_implements_combat_phase()
			_end_turn()


func _implements_card_placement_phase() -> void:
	current_phase = BattlePhase.CARD_PLACEMENT
	get_tree().call_group("characters", "prepare_for_card_placement")
	CardPlacementManager.enemies_auto_selecting_cards(enemy_team.characters, ally_team.characters)


func _implements_combat_phase() -> void:
	current_phase = BattlePhase.COMBAT
	emit_signal("combat_started")
	get_tree().call_group("characters", "prepare_for_combat")
	CombatManager.set_assaults(CardPlacementManager.get_assaults())
	CombatManager.activate_assaults()


func _start_turn() -> void:
	turn_number += 1
	emit_signal("turn_started", turn_number)

func _end_turn() -> void:
	await CombatManager.combat_end
	if enemy_team.is_defeated():
		victory()
		return
	if ally_team.is_defeated():
		defeate()
		return
	
	emit_signal("turn_ended")
	_switch_battle_phase()


func _init_of_teams() -> void:
	var left_popup: BasePopupWithCharacterInfo = $UI/PopupWithCharacterInfo/Left
	var right_popup: BasePopupWithCharacterInfo = $UI/PopupWithCharacterInfo/Right
	ally_team.set_popup_with_character_info(
			left_popup if Settings.gameplay_settings.allies_placement.is_left else right_popup)
	enemy_team.set_popup_with_character_info(
			left_popup if not Settings.gameplay_settings.allies_placement.is_left else right_popup)


func _connect_signals() -> void:
	#PlayerState.set_assault.connect(_on_player_set_assault)
	turn_started.connect(CardPlacementManager._on_battle_turn_started)
	turn_started.connect(_battlefield._on_battle_turn_started)
	combat_started.connect(_battlefield._on_battle_combat_started)


#func _on_player_set_assault() -> void:
#	var ally_speed_dice: AbstractSpeedDice = _right_commander.selected_speed_dice
#	var enemy_speed_dice: AbstractSpeedDice = _left_commander.selected_speed_dice
#	CardPlacementManager.set_assault(ally_speed_dice, enemy_speed_dice)
