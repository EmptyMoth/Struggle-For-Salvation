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

const _MULTIPLIER_BY_RESISTANCE: Dictionary = {
	Resistance.IMMUNITY: 0.0,
	Resistance.INEFFECTIVE: 0.5,
	Resistance.WEAK: 0.75,
	Resistance.NORMAL: 1.0,
	Resistance.HIGH: 1.5,
	Resistance.FATAL: 2.0,
}

var default_multiplier: float :
	get: return _MULTIPLIER_BY_RESISTANCE[default_resistance]
var multiplier: float :
	get: return _MULTIPLIER_BY_RESISTANCE[resistance]

var default_resistance: Resistance
var resistance: Resistance


func _init(start_resistance: Resistance) -> void:
	default_resistance = start_resistance
	reset()


func reset() -> void:
	resistance = default_resistance


func change_resistance(new_resistance: Resistance) -> void:
	resistance = new_resistance


func _on_character_stunned() -> void:
	resistance = Resistance.FATAL


func _on_character_came_out_of_stun() -> void:
	reset()
