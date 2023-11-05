extends Node


@onready var packed_scene_transition: PackedScene = \
		preload("res://scenes/global/scene_transition/loading_screen.tscn")


func change_scene_to_file(path: String) -> void:
	get_tree().change_scene_to_packed(packed_scene_transition)
	var scene_transition: Node = await get_tree().node_added
	scene_transition.start_loading(path)
