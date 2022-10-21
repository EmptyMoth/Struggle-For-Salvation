class_name AbstractAbility
extends Node


enum Target {
	CHARACTER = 1,
	CARD = 2,
	DICE = 4,
}

var condition: AbilityCondition = null
var influence: AbilityInfluence = null


func _init(ability_condition: AbilityCondition, 
		ability_influence: AbilityInfluence) -> void:
	condition = ability_condition
	influence = ability_influence


class AbilityCondition:
	var check: Callable = null
	var description: String = null
	
	
	func _init(condition_check: Callable, 
			condition_description: String) -> void:
		check = condition_check
		description = condition_description


class AbilityInfluence:
	var apply: Callable = null
	var description: String = null
	var target: Target
	
	
	func _init(influence_apply: Callable, 
			influence_description: String,
			influence_target: Target) -> void:
		apply = influence_apply
		description = influence_description
		target = influence_target
