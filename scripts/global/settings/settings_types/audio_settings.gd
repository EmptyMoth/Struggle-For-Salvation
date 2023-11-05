class_name AudioSettings
extends AbstractSettingsType


static var general_volume := BaseSettingAudio.new(
		"general_volume", GlobalParameters.GENERAL_AUDIO_BUS)
static var music_volume := BaseSettingAudio.new(
		"music_volume", GlobalParameters.MUSIC_AUDIO_BUS)
static var sound_volume := BaseSettingAudio.new(
		"sound_volume", GlobalParameters.SOUND_AUDIO_BUS)
static var play_music_on_pause := BaseSettingsWithToggle.new("play_music_on_pause", true)


func _init(config: ConfigHandler) -> void:
	settings = [general_volume, music_volume, sound_volume, play_music_on_pause]
	super("audio", settings, config)
