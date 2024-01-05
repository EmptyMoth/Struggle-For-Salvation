extends Node


const GENERAL_AUDIO_BUS: String = "Master"
const MUSIC_AUDIO_BUS: String = "Music"
const SOUND_AUDIO_BUS: String = "Sound"


func get_nodes_in_group(group: StringName) -> Array[Node]:
	return get_tree().get_nodes_in_group(group)


func exit_game() -> void:
	get_tree().quit()
