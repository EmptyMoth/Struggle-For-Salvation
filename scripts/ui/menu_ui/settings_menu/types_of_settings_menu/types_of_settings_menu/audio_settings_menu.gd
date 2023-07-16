extends AbstractSettingsMenu


@onready var general_volume: HSlider = $Settings/GeneralVolume.get_button()
@onready var music_volume: HSlider = $Settings/MusicVolume.get_button()
@onready var sound_volume: HSlider = $Settings/SoundVolume.get_button()
@onready var play_music_on_pause: CheckButton = $Settings/PlayMusicOnPause.get_button()


func init() -> void:
	set_parameters(
		Settings.audio_settings,
		{}
	)
