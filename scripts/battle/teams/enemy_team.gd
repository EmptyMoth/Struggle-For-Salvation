class_name EnemyTeam
extends AbstractTeam


func _ready() -> void:
	_team_model = EnemyTeamModel.new()
	super._ready()


func _get_characters() -> Array:
	return get_tree().get_nodes_in_group("enemies")
