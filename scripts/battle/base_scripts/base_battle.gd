class_name BaseBattle
extends Node2D


signal turn_start
signal turn_end
signal combat_start

enum BattlePhase { CARD_PLACEMENT, COMBAT }

@export var _packed_formation: PackedScene

@export_group("Characters")
@export var _packed_allies: Array = []
@export var _packed_enemies: Array = []

var turns_count: int = 0
var current_phase: BattlePhase = BattlePhase.COMBAT

@onready var _battlefield: BaseBattlefield = $SubViewport/BaseBattlefield
@onready var ally_team: AbstractTeam = $Teams/AllyTeam
@onready var enemy_team: AbstractTeam = $Teams/EnemyTeam


func _ready() -> void:
	_battlefield.set_formation(_packed_formation.instantiate())
	
	_battlefield.set_characters_start_position_on_battlefield(
		ally_team.characters, enemy_team.characters)
	
	#PlayerState.set_assault.connect(_on_player_set_assault)
	turn_start.connect(CardPlacementManager._on_battle_turn_start)
	turn_start.connect(_battlefield._on_battle_turn_start)
	combat_start.connect(_battlefield._on_battle_combat_start)
	
	_switch_battle_phase()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_menu"):
		$CanvasLayer/PauseMenu.pause_game()
		
	if current_phase == BattlePhase.CARD_PLACEMENT:
		if Input.is_action_just_released("ui_switch_battle_phase"):
			_switch_battle_phase()
		if Input.is_action_just_released("ui_auto_selecting_cards"):
			CardPlacementManager.allies_auto_selecting_cards(ally_team.characters, enemy_team.characters)


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
	emit_signal("combat_start")
	get_tree().call_group("characters", "prepare_for_combat")
	CombatManager.set_assaults(CardPlacementManager.get_assaults())
	CombatManager.activate_assaults()


func _start_turn() -> void:
	turns_count += 1
	emit_signal("turn_start")

func _end_turn() -> void:
	await CombatManager.combat_end
	emit_signal("turn_end")
	_switch_battle_phase()


#func _on_player_set_assault() -> void:
#	var ally_speed_dice: AbstractSpeedDice = _right_commander.selected_speed_dice
#	var enemy_speed_dice: AbstractSpeedDice = _left_commander.selected_speed_dice
#	CardPlacementManager.set_assault(ally_speed_dice, enemy_speed_dice)
