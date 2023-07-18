class_name BaseFormation
extends Node3D


@onready var _allies_markers: Node3D = $AlliesMarkers
@onready var _enemies_markers: Node3D = $EnemiesMarkers
@onready var allies_positions_count: int = _allies_markers.get_child_count()
@onready var enemies_positions_count: int = _enemies_markers.get_child_count()
@onready var _allies_positions: PackedVector3Array = \
		_get_positions(_allies_markers)
@onready var _enemies_positions: PackedVector3Array = \
		_get_positions(_enemies_markers)


func _ready() -> void:
	($Battlefield as MeshInstance3D).hide()
	_flip_ally_team(Settings.gameplay_settings.allies_placement.is_left)


func get_ally_position_by_index(index: int) -> Vector3:
	return _allies_positions[index % allies_positions_count]

func get_enemy_position_by_index(index: int) -> Vector3:
	return _enemies_positions[index % enemies_positions_count]


func _get_positions(node_with_markers: Node3D) -> PackedVector3Array:
	var positions: PackedVector3Array = []
	for marker in node_with_markers.get_children():
		positions.append(marker.global_position)
	return positions


func _flip_ally_team(on_left: bool) -> void:
	rotate_y(0.0 if on_left else PI)
