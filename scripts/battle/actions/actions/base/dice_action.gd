class_name DiceAction
extends Resource


@export var motion: BattleParameters.CharactersMotions = \
		BattleParameters.CharactersMotions.DEFAULT
#@export var action_animation: ActionAnimation
var _action: Callable


func _init(_motion: BattleParameters.CharactersMotions, action: Callable) -> void:
	motion = _motion
	_action = action


func init(action:Callable) -> DiceAction:
	_action = action
	return self


func do(character: AbstractCharacter, target: AbstractCharacter) -> void:
	character.switch_motion(motion)
	#action_animation.set_participants(character, target)
	_action.call(character, target)
