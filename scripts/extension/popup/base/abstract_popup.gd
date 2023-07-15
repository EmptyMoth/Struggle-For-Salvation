class_name AbstractPopup
extends Control


## Node must have mouse_entered and mouse_exited signals
@export var _target_node: CanvasItem


func _ready() -> void:
	hide()
	connect_target_node(_target_node)


func connect_target_node(target_node: CanvasItem) -> void:
	if _target_node.has_signal("mouse_entered") and _target_node.has_signal("mouse_exited"):
		_target_node.mouse_entered.connect(_on_target_mouse_entered)
		_target_node.mouse_exited.connect(_on_target_mouse_exited)
	else:
		push_warning("WARNING. AbstractPopup: target node uncorrect")


func connect_target_nodes(target_nodes: Array) -> void:
	for target_node in target_nodes:
		connect_target_node(target_node)


func override_show() -> void:
	show()


func override_hide() -> void:
	hide()


func _on_target_mouse_entered() -> void:
	override_show()


func _on_target_mouse_exited() -> void:
	override_hide()
