class_name StageSelectionButton
extends TextureButton


signal story_stage_selected(selected_story_stage_info: StoryStageInfo)


@export var story_stage_info: StoryStageInfo


func _ready() -> void:
	texture_normal = story_stage_info.icon


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		story_stage_selected.emit(story_stage_info)
