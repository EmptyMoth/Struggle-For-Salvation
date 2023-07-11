class_name AudioSettings
extends AbstractSettings


const MAX_VOLUME: int = 100

var general_volume: int = MAX_VOLUME :
	set(value):
		general_volume = value
		_set_volume_on_bus("Master", general_volume)
		_save_change_setting("general_volume", general_volume)
var music_volume: int = MAX_VOLUME :
	set(value):
		music_volume = value
		_set_volume_on_bus("Music", music_volume)
		_save_change_setting("music_volume", music_volume)
var sound_volume: int = MAX_VOLUME :
	set(value):
		sound_volume = value
		_set_volume_on_bus("Sound", sound_volume)
		_save_change_setting("sound_volume", sound_volume)
var whether_to_play_music_during_pause: bool = true :
	set(value):
		whether_to_play_music_during_pause = value
		_save_change_setting("whether_to_play_music_during_pause", whether_to_play_music_during_pause)


func _init(config: ConfigHandler) -> void:
	super(config, "audio")


func _set_volume_on_bus(bus_name: String, new_value: int) -> void:
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(new_value / float(MAX_VOLUME)))
