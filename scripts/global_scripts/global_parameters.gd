extends Node


@onready var random: RandomNumberGenerator = RandomNumberGenerator.new() :
	get: return random


@onready var resolution: Vector2 = \
	Config.INDEX_BY_RESOLUTION[Config.ResolutionIndex.RESOLUTION_1920_1080]
@onready var location_of_ally_team_on_battlefield: Config.LocationOfAllyTeamOnBattlefield = \
	Config.LocationOfAllyTeamOnBattlefield.LEFT


func _ready() -> void:
	random.randomize()


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_menu"):
		get_tree().quit()
