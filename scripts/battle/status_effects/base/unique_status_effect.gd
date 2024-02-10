class_name UniqueStatusEffect
extends AbstractStatusEffect


func reduce() -> void:
	expired.emit(self)
