extends BaseBattle


@onready var _training_screen: TrainingScreen = $CanvasUI/TrainingScreen


func _start_next_turn() -> void:
	super()
	match turn_number:
		1:
			_training_screen.open_training(1, 6)
		2:
			_training_screen.open_training(7, 8)
		3:
			_training_screen.open_training(9, 10)


func _on_preparation_started() -> void:
	super()
	$CanvasUI/Tooltip.show()

func _on_combat_started() -> void:
	super()
	$CanvasUI/Tooltip.hide()
