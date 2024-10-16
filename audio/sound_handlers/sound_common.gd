class_name SoundCommon
extends Resource


var sound: FmodEvent


func _init(sound_id: int) -> void:
	sound = SoundEvents.create_event(sound_id)


func play() -> void:
	sound.start()
