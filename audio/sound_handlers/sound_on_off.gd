class_name SoundOnOff
extends SoundCommon


var sound_off: FmodEvent


func _init(sound_id_on: int, sound_id_off: int) -> void:
	super(sound_id_on)
	sound_off = SoundEvents.create_event(sound_id_off)


func play(toggled_on: bool = true) -> void:
	(sound if toggled_on else sound_off).start()
