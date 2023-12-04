class_name PhysicalHealth
extends AbstractHealth


signal died


func _reached_zero() -> void:
	super()
	died.emit()
