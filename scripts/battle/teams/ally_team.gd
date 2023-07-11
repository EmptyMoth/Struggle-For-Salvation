class_name AllyTeam
extends AbstractTeam


func _ready() -> void:
	for ally in characters:
		ally.add_to_group("allies")
	_team_model = AllyTeamModel.new()
	super._ready()
