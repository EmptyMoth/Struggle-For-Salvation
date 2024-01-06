extends Node


const GENERAL_AUDIO_BUS: String = "Master"
const MUSIC_AUDIO_BUS: String = "Music"
const SOUND_AUDIO_BUS: String = "Sound"

const FOLDER_WITH_LOCATION_TEXTURE: String = "res://sprites/ui/menu/locations/"


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("NOTIFICATION_WM_CLOSE_REQUEST")


func get_nodes_in_group(group: StringName) -> Array[Node]:
	return get_tree().get_nodes_in_group(group)


func change_scene_with_transition(scene: String) -> void:
	SceneTransition.change_scene_to_file(scene)

func change_scene(scene: String) -> void:
	get_tree().change_scene_to_file(scene)


func exit_game() -> void:
	get_tree().quit()
