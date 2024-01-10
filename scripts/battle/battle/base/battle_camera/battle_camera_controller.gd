class_name BattleCameraController
extends Node


static var battle_camera: BattleCamera = null
static var battlefielf_camera: BattlefieldCamera = null

static var _character_1: Character = null
static var _character_2: Character = null


func _ready() -> void:
	BattleSignals.battle_started.connect(_on_battle_started)
	BattleSignals.battle_ended.connect(_on_battle_ended)
	BattleSignals.preparation_started.connect(_on_battle_preparaion_started)
	BattleSignals.combat_started.connect(_on_battle_combat_started)
	BattleSignals.combat_ended.connect(_on_battle_combat_ended)
	BattleSignals.assault_started.connect(_on_assault_started)


func _input(event: InputEvent) -> void:
	if PlayerState.is_observer():
		return
	battle_camera.player_moves_camera(event)
	battlefielf_camera.player_moves_camera(event)


func _process(delta: float) -> void:
	if _character_1 == null and _character_2 == null:
		return
	var distance: float = (_character_1.position - _character_2.position).length()
	var zoom: Vector2 = Vector2.ONE * clampf(1200 / distance, 1.2, 3)
	var assault_position: Vector2 = (_character_1.position + _character_2.position) / 2
	assault_position.y -= 100
	battle_camera.move_to(assault_position, zoom, delta)


static func _on_battle_started() -> void:
	battle_camera = BaseBattle.battle.get_viewport().get_camera_2d()
	battlefielf_camera = BaseBattle.battle._battlefield.get_viewport().get_camera_3d()


static func _on_battle_ended() -> void:
	battle_camera = null
	battlefielf_camera = null


static func _on_battle_preparaion_started() -> void:
	battle_camera.move_to_default_position()
	battlefielf_camera.move_to_default_position()


static func _on_battle_combat_started() -> void:
	battlefielf_camera.move_to_combat_position()


static func _on_battle_combat_ended() -> void:
	_character_1 = null
	_character_2 = null


static func _on_assault_started(character_1: Character, character_2: Character) -> void:
	return
	_character_1 = character_1
	_character_2 = character_2
	#var distance: float = (_character_1.position - _character_2.position).length()
	#var assault_position: Vector2 = (_character_1.position + _character_2.position) / 2
	#var zoom: Vector2 = Vector2.ONE * clampf(1200 / distance, 0.8, 2)
	#battle_camera.move_to(assault_position, zoom)
