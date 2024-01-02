class_name Action
extends Resource


signal finished

@export var _action_parts: Array[ActionPart] = []


func _init(action_motions: Array[ActionPart] = []) -> void:
	_action_parts = action_motions


func execute(user: Character, main_opponent: Character, sub_targets: Array[Character] = []) -> void:
	for action_part: ActionPart in _action_parts:
		for opponent in sub_targets:
			action_part.opponent_motion.execute(opponent, user)
		
		if action_part.user_motion.duration >= action_part.opponent_motion.duration:
			action_part.opponent_motion.execute(main_opponent, user)
			await action_part.user_motion.execute(user, main_opponent, sub_targets)
		else:
			action_part.user_motion.execute(user, main_opponent, sub_targets)
			await action_part.opponent_motion.execute(main_opponent, user)
	
	finished.emit()
