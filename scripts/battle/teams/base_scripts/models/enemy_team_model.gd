class_name EnemyTeamModel
extends BaseTeamModel


func _get_top_corner_hud() -> BaseTopCornerHUD:
	return preload("res://scenes/ui/battle_ui/characters_ui/huds/top_corner_hud/right_top_corner_hud.tscn").instantiate() \
		if GlobalParameters.location_of_ally_team_on_battlefield == Config.LocationOfAllyTeamOnBattlefield.LEFT \
		else preload("res://scenes/ui/battle_ui/characters_ui/huds/top_corner_hud/left_top_corner_hud.tscn").instantiate()
