class_name AllyTeam
extends AbstractTeam


func _ready() -> void:
	_team_model = AllyTeamModel.new()
	super._ready()


func _get_characters() -> Array:
	return get_tree().get_nodes_in_group("allies")
