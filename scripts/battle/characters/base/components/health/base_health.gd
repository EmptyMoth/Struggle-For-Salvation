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


func _init(max_value: int) -> void:
	max_health = max_value
	recover()


func recover() -> void:
	current_health = max_health


func reduce_max_value(value: int) -> void:
	max_health = max(1, max_health - value)


func take_damage(damage: int) -> void:
	current_health = max(0, current_health - damage)
	if is_empty:
		reached_zero.emit()


func heal(value: int) -> void:
	current_health = min(current_health + value, max_health)
