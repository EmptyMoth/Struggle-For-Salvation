extends Node


signal battle_started
signal battle_ended

signal turn_started
signal turn_ended

signal preparation_started
signal preparation_ended

signal combat_started
signal combat_ended


func _ready() -> void:
	battle_started.connect(PlayerInputManager._on_battle_started)
	battle_ended.connect(PlayerInputManager._on_battle_ended)
	
	battle_started.connect(PreparationPhaseManager._on_battle_started)
	turn_started.connect(PreparationPhaseManager._on_battle_turn_started)
