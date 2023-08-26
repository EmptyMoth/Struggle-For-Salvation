class_name AbstractSkill
extends Resource


@export var stats: SkillStats


func _init() -> void:
	BattleSygnals.turn_started.connect(_on_battle_turn_started)


func is_blocked() -> bool:
	return false


func select() -> void:
	pass

func deselect() -> void:
	pass


func use() -> SkillCombatModel:
	return SkillCombatModel.new(stats)


func _on_battle_turn_started(_turn_number: int) -> void:
	pass
