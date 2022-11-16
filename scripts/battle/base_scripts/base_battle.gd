class_name BaseBattle
extends Node2D


enum BattlePhase { CARD_PLACEMENT, COMBAT }

@export var _packed_formation: PackedScene

var characters: Array[AbstractCharacter] :
	get: return ally_team + enemy_team
var ally_team: Array[Node] :
	get: return $Characters/Allies.get_children()
var enemy_team: Array[Node] :
	get: return $Characters/Enemies.get_children()

var turns_count: int = 0
var current_phase: BattlePhase = BattlePhase.COMBAT

@onready var _battlefield: BaseBattlefield = $SubViewport/Battle3D
@onready var _formation: Formation = _packed_formation.instantiate()


func _ready() -> void:
	_battlefield.set_formation(_formation)
	
	for ally in ally_team:
		_set_ally_start_position_on_battlefield(ally)
	for enemy in enemy_team:
		_set_enemy_start_position_on_battlefield(enemy)
	
	_switch_battle_phase()


func _input(_event: InputEvent) -> void:
	if current_phase == BattlePhase.CARD_PLACEMENT \
			and Input.is_action_just_pressed("ui_switch_battle_phase"):
		_switch_battle_phase()


func end() -> void:
	pass


func _switch_battle_phase() -> void:
	match current_phase:
		BattlePhase.COMBAT:
			turns_count += 1
			_implements_card_placement_phase()
		BattlePhase.CARD_PLACEMENT:
			_implements_combat_phase()
			_switch_battle_phase()


func _implements_card_placement_phase() -> void:
	current_phase = BattlePhase.CARD_PLACEMENT
	get_tree().call_group("characters", "prepare_for_card_placement")


func _implements_combat_phase() -> void:
	current_phase = BattlePhase.COMBAT
	get_tree().call_group("characters", "prepare_for_combat")


func _set_ally_start_position_on_battlefield(ally: AbstractCharacter) -> void:
	var ally_marker: CharacterMarker3D = ally.character_marker_3d
	var allies: Node3D = _battlefield.get_node("Characters/Allies")
	_formation.set_ally_start_position(ally_marker, ally.get_index())
	allies.add_child(ally_marker)


func _set_enemy_start_position_on_battlefield(enemy: AbstractCharacter) -> void:
	var enemy_marker: CharacterMarker3D = enemy.character_marker_3d
	var enemies: Node3D = _battlefield.get_node("Characters/Enemies")
	_formation.set_enemy_start_position(enemy_marker, enemy.get_index())
	enemies.add_child(enemy_marker)
