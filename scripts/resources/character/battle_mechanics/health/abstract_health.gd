class_name AbstractHealth
extends Resource


signal health_changed(new_value: int)

var max_health: int = 0
var current_health: int = 0 : 
	set(health):
		current_health = health
		if health == 0:
			_reached_zero()
		
		@warning_ignore("return_value_discarded")
		emit_signal("health_changed", current_health)


func _init(max_value: int) -> void:
	max_health = max_value
	reset()


func reset() -> void:
	current_health = max_health


func reduce_max_value(count: int) -> void:
	max_health = max(1, max_health - count)


func take_damage(count: int) -> void:
	current_health = max(0, current_health - count)


func heal(count: int) -> void:
	current_health = min(current_health + count, max_health)


func _reached_zero() -> void:
	pass
