class_name BaseBattlefield
extends Node3D


var _formation: Formation

@onready var _battlefield_camera: BattlefieldCamera = $BattlefieldCamera


func set_formation(formation: Formation) -> void:
	_formation = formation
	add_child(formation)


func set_ally_start_position_on_battlefield(ally: AbstractCharacter) -> void:
	var team: Node3D = $Characters/Allies
	team.add_child(ally.character_marker_3d)
	_formation.set_ally_start_position(ally.character_marker_3d, ally.get_index())

func set_enemy_start_position_on_battlefield(enemy: AbstractCharacter) -> void:
	var team: Node3D = $Characters/Enemies
	team.add_child(enemy.character_marker_3d)
	_formation.set_enemy_start_position(enemy.character_marker_3d, enemy.get_index())


func _on_battle_turn_start() -> void:
	_battlefield_camera.move_to_normal_position()

func _on_battle_combat_start() -> void:
	_battlefield_camera.move_to_combat_position()
