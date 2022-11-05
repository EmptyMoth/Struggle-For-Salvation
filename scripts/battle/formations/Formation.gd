class_name Formation
extends Node3D


var ally_positions_count: int :
	get: return _ally_positions.get_child_count()

var enemy_positions_count: int :
	get: return _enemy_positions.get_child_count()

var positions_count: int :
	get: return ally_positions_count + enemy_positions_count

@onready var _ally_positions: Node3D = $AllyPositions
@onready var _enemy_positions: Node3D = $EnemyPositions


func _ready() -> void:
	($Battlefield as MeshInstance3D).hide()


func flip_horizontally() -> void:
	rotate_y(PI)


func set_ally_start_position(
		character_marker: CharacterMarker3D, character_index: int) -> void:
	var marker: Marker3D = _ally_positions.get_child(character_index)
	_set_start_position(character_marker, marker)


func set_enemy_start_position(
		character_marker: CharacterMarker3D, character_index: int) -> void:
	var marker: Marker3D = _enemy_positions.get_child(character_index)
	_set_start_position(character_marker, marker)


func _set_start_position(
		character_marker: CharacterMarker3D, marker: Marker3D) -> void:
	character_marker.set_start_position(marker.position)
