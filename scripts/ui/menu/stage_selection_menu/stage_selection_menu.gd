class_name StageSelectionMenu
extends Control


@onready var _panel_stage_info: PanelStageInfo = $PanelStageInfo

var _selected_story_stage_info: StoryStageInfo


func _ready() -> void:
	_panel_stage_info._start_button.pressed.connect(_on_pressed_start_stage)
	for story_stage: StageSelectionButton in $StoryStages.get_children():
		story_stage.story_stage_selected.connect(_on_story_stage_selected)


func _on_story_stage_selected(selected_story_stage_info: StoryStageInfo) -> void:
	_selected_story_stage_info = selected_story_stage_info
	_panel_stage_info.set_stage_info(selected_story_stage_info.title, false)
	await get_tree().process_frame
	_panel_stage_info.position = Vector2(1920, 540) - Vector2(_panel_stage_info.size.x, _panel_stage_info.size.y / 2.0)
	_panel_stage_info.show()


func _on_pressed_start_stage() -> void:
	GlobalParameters.change_scene_with_transition("res://tests/battle/test_battle.tscn")
