class_name BaseHealth
extends Resource


signal health_changed(new_value: int)
signal reached_zero

var max_health: int = 0
var current_health: int = 0 : 
	set(health):
		current_health = health
		health_changed.emit(current_health)
var is_empty: bool :
	get: return current_health <= 0

var resistance: BaseResistance


func _init(max_value: int, default_resistance: BaseResistance.ResistanceType) -> void:
	max_health = max_value
	resistance = BaseResistance.new(default_resistance)
	recover()


func recover() -> void:
	current_health = max_health


func reduce_max_value(value: int) -> void:
	max_health = max(1, max_health - value)


func take_damage(is_permanent: bool, damage: int) -> int:
	var final_damage: int = damage if is_permanent else roundi(damage * resistance.multiplier)
	_take_damage(final_damage)
	return final_damage


func heal(value: int) -> void:
	current_health = min(current_health + value, max_health)


func _take_damage(damage: int) -> void:
	current_health = max(0, current_health - damage)
	if is_empty:
		reached_zero.emit()
