@tool
class_name ActionPart
extends Resource


const DEFAULT_DURATION: float = 0.6

@export_range(0, 1, 0.01, "or_greater") var duration: float = DEFAULT_DURATION
@export var user_motion: AbstractMotion
@export var opponent_motion: AbstractMotion = NothingMotion.DEFAULT


func _init(
			_user_motion: AbstractMotion = null,
			_opponent_motion: AbstractMotion = NothingMotion.new(),
			_duration: float = DEFAULT_DURATION) -> void:
	user_motion = _user_motion
	opponent_motion = _opponent_motion
	duration = _duration


func execute(user: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> void:
	opponent_motion.duration = duration
	user_motion.duration = duration
	for opponent in sub_targets:
		opponent_motion.execute(opponent, user)
	opponent_motion.execute(main_opponent, user)
	await user_motion.execute(user, main_opponent, sub_targets)
