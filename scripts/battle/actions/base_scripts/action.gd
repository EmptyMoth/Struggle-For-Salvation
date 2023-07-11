class_name Action
extends Node


var action: BattleParameters.CharactersActions
var action_effect: SpriteFrames
var motion: Motion


class Motion:
	var for_user: Callable
	var for_opponent: Callable
