class_name AbstractAbility
extends Resource


enum Target {
	CHARACTER = 1,
	CARD = 2,
	DICE = 4,
}

@export_multiline var description: String = ""

var condition: AbilityCondition = null
var influence: AbilityInfluence = null


func _init(ability_condition: AbilityCondition, 
		ability_influence: AbilityInfluence) -> void:
	condition = ability_condition
	influence = ability_influence


class AbilityCondition:
	#var check: Callable = null
	var check = null
	#var description: String = null
	var description = null
	
	
	func _init(condition_check: Callable, 
			condition_description: String) -> void:
		check = condition_check
		description = condition_description


class AbilityInfluence:
	pass
	#var apply: Callable = null
	var apply = null
	#var description: String = null
	var description = null
	var target: Target
	
	
	func _init(influence_apply: Callable, 
			influence_description: String,
			influence_target: Target) -> void:
		apply = influence_apply
		description = influence_description
		target = influence_target
