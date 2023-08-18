class_name PhysicalHealth
extends AbstractHealth


signal died


func _reached_zero() -> void:
	super._reached_zero()
	@warning_ignore("return_value_discarded")
	emit_signal("died")
