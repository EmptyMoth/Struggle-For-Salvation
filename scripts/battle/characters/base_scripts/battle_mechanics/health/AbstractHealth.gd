class_name AbstractHealth
extends Node


signal health_changed(new_value: int)

var max_health: int = 0
var current_health: int = 0


func _init(max_value: int) -> void:
	max_health = max_value
	current_health = max_value
	emit_signal("health_changed", current_health)


func reduce_max_value(count: int) -> void:
	max_health -= count
	if max_health < 1:
		max_health = 1


func decrease(count: int) -> void:
	current_health -= count
	if current_health <= 0:
		_reached_zero()
	
	emit_signal("health_changed", current_health)


func restore(count: int) -> void:
	current_health += count
	if current_health > max_health:
		current_health = max_health
	
	emit_signal("health_changed", current_health)


func _reached_zero() -> void:
	current_health = 0
