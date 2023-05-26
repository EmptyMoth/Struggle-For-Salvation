class_name ButtonLevelSelect
extends TextureButton


@export var scene_path: String = ""
@export var prerequisites: Array = []


func _ready():
	var unlocked: bool = true
	
	disabled = true
	hide()
	
	for t in prerequisites:
		if not Saves.is_complete(t):
			unlocked = false
			break
	
	if unlocked:
		disabled = false
		show()


func _on_pressed() -> void:
	get_tree().change_scene_to_file(scene_path)
