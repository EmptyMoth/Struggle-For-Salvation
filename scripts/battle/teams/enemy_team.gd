class_name EnemyTeam
extends AbstractTeam


func _ready() -> void:
	for ally in characters:
		ally.add_to_group("enemies")
	_team_model = EnemyTeamModel.new()
	super._ready()
