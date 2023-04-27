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
	_flip_ally_team_on_right() \
		if GlobalParameters.location_of_ally_team_on_battlefield == GlobalParameters.LocationOfAllyTeamOnBattlefield.RIGHT \
		else _flip_ally_team_on_left()
	($Battlefield as MeshInstance3D).hide()


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
	character_marker.set_start_position(marker.global_position)
	marker.add_child(character_marker)


func _flip_ally_team_on_left() -> void:
	rotation = Vector3(0, PI, 0)

func _flip_ally_team_on_right() -> void:
	rotation = Vector3(0, 0, 0)
