class_name Action
extends Resource


signal finished

@export var _action_parts: Array[ActionPart] = []


func _init(action_motions: Array[ActionPart] = []) -> void:
	_action_parts = action_motions


func execute(user: Character, opponents: Opponents) -> void:
	for action_part: ActionPart in _action_parts:
		for opponent in opponents.get_all_opponents():
			action_part.opponent_motion.execute(opponent, user)
		await action_part.user_motion.execute(user, opponents.main, opponents.sub_targets)
	finished.emit()
