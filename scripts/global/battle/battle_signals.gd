extends Node


signal battle_started
signal battle_ended

signal turn_started
signal turn_ended

signal preparation_started
signal preparation_ended

signal combat_started
signal combat_ended

signal assault_started(character: Character, target: Character)
signal assault_ended(character: Character, target: Character)
signal one_side_started(character: Character, target: Character)
signal clash_started(opponent_1: Character, opponent_2: Character)
signal clash_continued(opponent_1: Character, opponent_2: Character)
signal clash_ended(opponent_1: Character, opponent_2: Character)


func _ready() -> void:
	battle_started.connect(PlayerInputManager._on_battle_started)
	battle_ended.connect(PlayerInputManager._on_battle_ended)
	turn_started.connect(PreparationPhaseManager._on_battle_turn_started)
	
	preparation_ended.connect(CombatPhaseManager._on_battle_preparation_ended)
