extends AbstractSettingsMenu


func _ready() -> void:
	_settings_server = Settings.audio_settings
	$Settings/GeneralVolume.set_setting(_settings_server.general_volume)
	$Settings/MusicVolume.set_setting(_settings_server.music_volume)
	$Settings/SoundVolume.set_setting(_settings_server.sound_volume)
	$Settings/PlayMusicOnPause.set_setting(_settings_server.play_music_on_pause)
