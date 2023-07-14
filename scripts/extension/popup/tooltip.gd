class_name Tooltip
extends AbstractPopup


@export_range(0.05, 5, 0.05, "or_greater", "suffix:s") var _delay_before_appearance: float = 0.5
@export var _position_depends_on_mouse: bool = true
@export var _follow_mouse: bool = true
@export var offset: Vector2i = Vector2i.ZERO
@export var padding: Vector2i = Vector2i.ZERO

@onready var _timer: Timer = $Timer


func _ready() -> void:
	super()
	_configure_mouse_filter_to_ignore()
	_timer.wait_time = _delay_before_appearance
	_timer.timeout.connect(override_show)


func _process(delta: float) -> void:
	if _follow_mouse and visible:
		_change_location()


func _draw() -> void:
	_change_location()


func override_show() -> void:
	_timer.stop()
	show()


func _configure_mouse_filter_to_ignore() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	self.child_entered_tree.connect(_on_child_entered_tree)
	for child in get_children():
		if child is Control:
			child.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _change_location() -> void:
	var target_global_position: Vector2 = _get_target_global_position()
	var borders: Vector2i = get_viewport().size - padding
	global_position = _get_global_position_taking_into_account_borders(
			target_global_position, borders)


func _get_target_global_position() -> Vector2:
	return get_global_mouse_position() \
			if _position_depends_on_mouse or _follow_mouse \
			else _target_node.global_position


func _get_global_position_taking_into_account_borders(
		target_global_position: Vector2, borders: Vector2) -> Vector2:
	var new_global_posiion: Vector2 = Vector2(
			target_global_position.x + offset.x, 
			target_global_position.y - size.y - offset.y
	)
	var position_on_viewport: Vector2 = get_viewport_transform() \
			* (new_global_posiion + Vector2(size.x, 0))
	if position_on_viewport.x > borders.x:
		new_global_posiion.x = target_global_position.x - size.x - offset.x
	if position_on_viewport.y < padding.y:
		new_global_posiion.y = target_global_position.y + offset.y
	return new_global_posiion


func _on_target_mouse_entered() -> void:
	_timer.start()


func _on_target_mouse_exited() -> void:
	_timer.stop()
	override_hide()


func _on_child_entered_tree(node: Node) -> void:
	if node is Control:
		node.mouse_filter = Control.MOUSE_FILTER_IGNORE
