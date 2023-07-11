class_name AllyTeamModel
extends BaseTeamModel


func _get_top_corner_hud() -> BaseTopCornerHUD:
	return preload("res://scenes/ui/battle_ui/characters_ui/huds/top_corner_hud/right_top_corner_hud.tscn").instantiate() \
		if Settings.gameplay_settings.is_location_of_allies_on_left_battlefield() \
		else preload("res://scenes/ui/battle_ui/characters_ui/huds/top_corner_hud/left_top_corner_hud.tscn").instantiate()
