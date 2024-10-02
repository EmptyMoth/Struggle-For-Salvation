class_name PanelStageInfo
extends PanelContainer


@onready var _title_label: Label = $Margin/VBox/Title
@onready var _start_button: Button = $Margin/VBox/StartButton
@onready var _story_replay: HBoxContainer = $Margin/VBox/StoryReplay
@onready var _pre_story_button: Button = $Margin/VBox/StoryReplay/StoryButtons/PreStoryButton
@onready var _during_story_button: Button = $Margin/VBox/StoryReplay/StoryButtons/DuringStoryButton
@onready var _post_story_button: Button = $Margin/VBox/StoryReplay/StoryButtons/PostStoryButton


func set_stage_info(title: String, is_completed: bool) -> void:
	_title_label.text = title
	_story_replay.visible = is_completed
