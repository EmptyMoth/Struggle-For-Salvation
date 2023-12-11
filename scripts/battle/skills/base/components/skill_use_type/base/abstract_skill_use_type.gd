class_name AbstractSkillUseType
extends Resource


func _init(_data: AbstractSkillUseTypeData) -> void:
	pass


func is_available() -> bool:
	return true


func select() -> void:
	pass

func deselect() -> void:
	pass


func restore() -> void:
	pass


func get_data() -> AbstractSkillUseTypeData:
	return get("_data")


func _on_skill_used() -> void:
	pass
