class_name BaseBattlefield
extends Node3D


var _formation: Formation

@onready var _battlefield_camera: BattlefieldCamera = $BattlefieldCamera


func set_formation(formation: Formation) -> void:
	_formation = formation
	add_child(formation)


func set_characters_start_position_on_battlefield(
			allies: Array, enemies: Array) -> void:
	for ally in allies:
		_formation.set_ally_start_position(ally.character_marker_3d, ally.get_index())
	for enemy in enemies:
		_formation.set_enemy_start_position(enemy.character_marker_3d, enemy.get_index())


func _on_battle_turn_started(_turn_number: int) -> void:
	_battlefield_camera.move_to_start_position()

func _on_battle_combat_started() -> void:
	_battlefield_camera.move_to_combat_position()
