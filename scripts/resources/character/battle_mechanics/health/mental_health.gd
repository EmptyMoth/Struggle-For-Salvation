class_name MentalHealth
extends AbstractHealth


signal stunned


func _reached_zero() -> void:
	super._reached_zero()
	@warning_ignore(return_value_discarded)
	emit_signal("stunned")
