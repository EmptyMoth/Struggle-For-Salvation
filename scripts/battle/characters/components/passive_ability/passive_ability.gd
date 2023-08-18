class_name PassiveAbility
extends Resource


@export var name: String = "Name of Passive Ability"
@export var description: String = "Description of passive ability"


func _to_string() -> String:
	return "%s - %s" % [name, description]
