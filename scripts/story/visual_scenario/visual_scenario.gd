class_name VisualScenario
extends Resource


@export var dialogs: Array[BaseDialog] = []


var _current_index_dialog: int = 0


func get_next_visual_dialog_or_null(current_id: int) -> BaseDialog:
	if _current_index_dialog >= dialogs.size():
		return null
	
	var current_dialog: BaseDialog = dialogs[_current_index_dialog]
	if current_dialog.id == current_id:
		_current_index_dialog += 1
		return current_dialog
	return null
