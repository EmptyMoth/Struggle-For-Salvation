class_name ButtonLevelSelect
extends TextureButton


@export_file(".tscn") var packed_scene: String
@export var level_id: String = ""
@export var prerequisites: Array = []

@export_group("Unfinished")
@export var texture_unfinished_default: Texture2D
@export var texture_unfinished_hover: Texture2D
@export var texture_unfinished_press: Texture2D

@export_group("Finished")
@export var texture_finished_default: Texture2D
@export var texture_finished_hover: Texture2D
@export var texture_finished_press: Texture2D


func _ready():
	var unlocked: bool = true
	
	disabled = true
	hide()
	
	for t in prerequisites:
		if not Saves.is_finished(t):
			unlocked = false
			break
	
	if unlocked:
		disabled = false
		show()
	
	if Saves.is_finished(level_id):
		texture_normal = texture_finished_default
		texture_hover = texture_finished_hover
		texture_pressed = texture_finished_press
	else:
		texture_normal = texture_unfinished_default
		texture_hover = texture_unfinished_hover
		texture_pressed = texture_unfinished_press


func _on_pressed() -> void:
	get_tree().change_scene_to_file(packed_scene)
