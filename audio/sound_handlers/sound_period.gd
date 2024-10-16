class_name SoundPeriod
extends SoundCommon


var _timer: SceneTreeTimer
var _time_sec: float


func _init(sound_id: int, time_sec: float) -> void:
	_time_sec = time_sec
	super(sound_id)


func play() -> void:
	if _timer != null and _timer.time_left > 0:
		return
	super()
	_timer = GlobalParameters.get_tree().create_timer(_time_sec)
