class_name BaseBattle
extends Node2D


enum BattlePhase { CARD_PLACEMENT, COMBAT }

var characters: Array[AbstractCharacter] = []
var ally_team: Array[AbstractCharacter] = []
var enemy_team: Array[AbstractCharacter] = []

var turns_count: int = 0
var current_phase: BattlePhase = BattlePhase.CARD_PLACEMENT


func _ready() -> void:
	for ally in $Characters/Allies.get_children():
		ally_team.append(ally)
	for enemy in $Characters/Enemies.get_children():
		enemy_team.append(enemy)
	characters = ally_team + enemy_team
	
	_switch_battle_phase()


func _switch_battle_phase() -> void:
	match current_phase:
		BattlePhase.COMBAT:
			turns_count += 1
			current_phase = BattlePhase.CARD_PLACEMENT
			_implements_card_placement_phase()
		BattlePhase.CARD_PLACEMENT:
			current_phase = BattlePhase.COMBAT
			_implements_combat_phase()


func _implements_card_placement_phase() -> void:
	pass


func _implements_combat_phase() -> void:
	pass
