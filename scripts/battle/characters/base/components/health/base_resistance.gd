class_name BaseResistance
extends Resource


enum ResistanceType {
	IMMUNITY = 0,
	INEFFECTIVE = 1,
	WEAK = 2,
	NORMAL = 3,
	HIGH = 4,
	FATAL = 5,
}

const _MULTIPLIER_BY_RESISTANCE: Dictionary = {
	ResistanceType.IMMUNITY: 0.0,
	ResistanceType.INEFFECTIVE: 0.5,
	ResistanceType.WEAK: 0.75,
	ResistanceType.NORMAL: 1.0,
	ResistanceType.HIGH: 1.5,
	ResistanceType.FATAL: 2.0,
}

var default_multiplier: float :
	get: return _MULTIPLIER_BY_RESISTANCE[default_resistance]
var multiplier: float :
	get: return _MULTIPLIER_BY_RESISTANCE[resistance]

var default_resistance: ResistanceType
var resistance: ResistanceType


func _init(start_resistance: ResistanceType) -> void:
	default_resistance = start_resistance
	reset()


func reset() -> void:
	resistance = default_resistance


func change_resistance(new_resistance: ResistanceType) -> void:
	resistance = new_resistance


func _on_character_stunned() -> void:
	resistance = ResistanceType.FATAL


func _on_character_came_out_of_stun() -> void:
	reset()
