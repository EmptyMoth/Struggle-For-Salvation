extends AbstractSettingsMenu


@onready var general_volume: HSlider = $Settings/GeneralVolume.get_button()
@onready var music_volume: HSlider = $Settings/MusicVolume.get_button()
@onready var sound_volume: HSlider = $Settings/SoundVolume.get_button()
@onready var whether_to_play_music_during_pause: CheckButton = \
	$Settings/WhetherToPlayMusicDuringPause.get_button()


func init() -> void:
	set_parameters(
		Settings.audio_settings,
		{}
	)
