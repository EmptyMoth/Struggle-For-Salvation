class_name ButtonSwitchScene
extends Button


@export_file("*.tscn") var scene_path: String
@export var with_scene_transition: bool = true 


func _on_pressed() -> void:
	if with_scene_transition:
		GlobalParameters.change_scene_with_transition(scene_path)
	else:
		GlobalParameters.change_scene(scene_path)
