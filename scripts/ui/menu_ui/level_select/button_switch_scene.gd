class_name ButtonSwitchScene
extends Button


@export_file("*.tscn") var scene_path: String


func _on_pressed() -> void:
	SceneTransition.change_scene_to_file(scene_path)
