class_name DiceAction
extends Resource


signal finished

var is_executing: bool = false


@export var motion: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.DEFAULT
#@export var action_animation: ActionAnimation
var _action: Callable


func _init(_motion: BattleEnums.CharactersMotions, action: Callable) -> void:
	motion = _motion
	_action = action


func init(action:Callable) -> DiceAction:
	_action = action
	return self


func execute(character: Character, target: Character) -> void:
	is_executing = false
	character.switch_motion(motion)
	#action_animation.set_participants(character, target)
	_action.call(character, target)
	finished.emit()
	is_executing = true
