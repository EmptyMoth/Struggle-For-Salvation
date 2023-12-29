class_name ActionPart
extends Resource


@export var user_motion: AbstractMotion
@export var opponent_motion: AbstractMotion = Knockback.DEFAULT


func _init(_user_motion: AbstractMotion = null, _opponent_motion: AbstractMotion = Nothing.new()) -> void:
	if _user_motion == null and _opponent_motion:
		assert("user_motion or opponent_motion is null")
	user_motion = _user_motion
	opponent_motion = _opponent_motion
