class_name PopupDialog
extends AbstractPopup


@export var fix_popup_on_screen: bool = false

var is_fixed: bool = false


func connect_target_node(target_node: CanvasItem) -> void:
	if _target_node.has_signal("mouse_entered") and _target_node.has_signal("mouse_exited"):
		_target_node.mouse_entered.connect(_on_target_mouse_entered)
		_target_node.mouse_exited.connect(_on_target_mouse_exited)
	else:
		push_warning("WARNING. AbstractPopup: target node uncorrect")
		return
	
	if not fix_popup_on_screen:
		return
	if _target_node is Control:
		_target_node.gui_input.connect(_on_target_input_event)
	elif _target_node is CollisionObject2D:
		_target_node.input_event.connect(_on_target_area_input_event)


func _on_target_mouse_entered() -> void:
	if not is_fixed:
		override_show()


func _on_target_mouse_exited() -> void:
	if not is_fixed:
		override_hide()


func _on_target_input_event(event: InputEvent) -> void:
	if fix_popup_on_screen and Input.is_action_just_released("ui_pick"):
		is_fixed = not is_fixed


func _on_target_area_input_event(
			_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	_on_target_input_event(event)
