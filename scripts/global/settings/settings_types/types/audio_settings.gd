class_name AudioSettings
extends AbstractSettingsType


static var general_volume := BaseSettingAudio.new("general_volume", "Master")
static var music_volume := BaseSettingAudio.new("music_volume", "Music")
static var sound_volume := BaseSettingAudio.new("sound_volume", "Sound")
static var play_music_on_pause := BaseSettingsWithToggle.new("play_music_on_pause", true)


func _init(config: ConfigHandler) -> void:
	settings = [general_volume, music_volume, sound_volume, play_music_on_pause]
	super("audio", settings, config)
