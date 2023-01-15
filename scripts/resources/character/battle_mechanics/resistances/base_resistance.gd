class_name BaseResistance
extends Resource


enum Resistance {
	IMMUNITY = 0,
	INEFFECTIVE = 1, 
	WEAK = 2,
	NORMAL = 3, 
	HIGH = 4, 
	FATAL = 5,
}

const RESISTANCE_MULTIPLIERS: Dictionary = {
	Resistance.IMMUNITY: 0,
	Resistance.INEFFECTIVE: 50,
	Resistance.WEAK: 75,
	Resistance.NORMAL: 100,
	Resistance.HIGH: 150,
	Resistance.FATAL: 200
}

var default_resistance: Resistance = Resistance.NORMAL
var resistance: Resistance = default_resistance


func _init(start_resistance: Resistance) -> void:
	default_resistance = start_resistance
	reset_resistance()


func get_default_value() -> float:
	return RESISTANCE_MULTIPLIERS[default_resistance] / 100.0


func get_value() -> float:
	return RESISTANCE_MULTIPLIERS[resistance] / 100.0


func reset_resistance() -> void:
	resistance = default_resistance


func change_resistance(new_resistance: Resistance) -> void:
	resistance = new_resistance


func _on_character_stunned() -> void:
	resistance = Resistance.FATAL


func _on_character_came_out_of_stun() -> void:
	reset_resistance()
