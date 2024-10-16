class_name Speaker
extends Sprite2D


var speaker: SpeakingCharacter


func set_speaker_setup(speaker_setup: SpeakerSetup) -> void:
	speaker = speaker_setup.speaker
	texture = speaker.sprite
	offset = Vector2(-texture.get_width() / 2.0, -texture.get_height() + 100)
	flip_h = not speaker_setup.is_looks_to_right
	var position_by_x: float = 1920 * speaker_setup.speaker_position_by_x / 100.0
	position = Vector2(position_by_x, 1080)
