class_name ButtonLevelSelect
extends TextureButton


@export var scene_path: String = ""
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
		if not Saves.is_completed(t):
			unlocked = false
			break
	
	if unlocked:
		texture_normal = texture_unfinished_default
		texture_hover = texture_unfinished_hover
		texture_pressed = texture_unfinished_press
		disabled = false
		show()
	else:
		texture_normal = texture_finished_default
		texture_hover = texture_finished_hover
		texture_pressed = texture_finished_press


func _on_pressed() -> void:
	get_tree().change_scene_to_file(scene_path)
