@tool
class_name StoryStageInfo
extends Resource


@export var title: String
@export var icon: Texture2D

@export_category("Story")
@export_file() var start_story: String
@export_file() var end_story: String

@export_category("Battle")
@export var location: String
@export var disease: BaseDisease
@export var waves: Array[WaveInfo] = [WaveInfo.new()]
@export_category("Player Team")
@export var max_count_allies: int
@export var fixed_allies: Array[CharacterInfo]
@export var selected_allies: SelectedAlliesInfo
