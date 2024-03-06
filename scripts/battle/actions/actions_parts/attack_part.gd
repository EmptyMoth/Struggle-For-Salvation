@tool
class_name AttackPart
extends ActionPart


func _init(
			_user_motion: AbstractMotion = DefaultAttackMotion.new(),
			_opponent_motion: AbstractMotion = DamageMotion.new()) -> void:
	user_motion = _user_motion
	opponent_motion = _opponent_motion
