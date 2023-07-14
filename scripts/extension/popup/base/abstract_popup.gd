class_name AbstractPopup
extends Control


## Node must have mouse_entered and mouse_exited signals
@export var _target_node: CanvasItem


func _ready() -> void:
	hide()
	_target_node.mouse_entered.connect(_on_target_mouse_entered)
	_target_node.mouse_exited.connect(_on_target_mouse_exited)


func override_show() -> void:
	show()


func override_hide() -> void:
	hide()


func _on_target_mouse_entered() -> void:
	override_show()


func _on_target_mouse_exited() -> void:
	override_hide()
