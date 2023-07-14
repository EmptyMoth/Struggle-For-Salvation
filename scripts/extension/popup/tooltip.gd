class_name Tooltip
extends AbstractPopup


@export_range(0, 5, 0.05, "or_greater", "suffix:s") var _delay_before_appearance: float = 0.5

@export var _position_depends_on_mouse: bool = true
@export var _follow_mouse: bool = true
@export var offset: Vector2i = Vector2i.ZERO
@export var padding: Vector2i = Vector2i.ZERO

@onready var _timer: Timer = $Timer


func _ready() -> void:
	super()
	_timer.wait_time = _delay_before_appearance
	_timer.timeout.connect(override_show)


func _process(delta: float) -> void:
	if _follow_mouse:
		var border = get_viewport().size - padding
		var base_pos = _get_screen_pos()
		
		# test if need to display to the left
		var final_x = base_pos.x + offset.x
		if final_x + size.x > border.x:
			final_x = base_pos.x - offset.x - size.x
		
		# test if need to display below
		var final_y = base_pos.y - size.y - offset.y
		if final_y < padding.y:
			final_y = base_pos.y + offset.y
		global_position = Vector2(final_x, final_y)


func _draw() -> void:
	var border = get_viewport().size - padding
	var base_pos = _get_screen_pos()
	# test if need to display to the left
	var final_x = base_pos.x + offset.x
	if final_x + size.x > border.x:
		final_x = base_pos.x - offset.x - size.x
	# test if need to display below
	var final_y = base_pos.y - size.y - offset.y
	if final_y < padding.y:
		final_y = base_pos.y + offset.y
	global_position = Vector2(final_x, final_y)


func _get_screen_pos() -> Vector2:
	return get_viewport().get_mouse_position() \
			if _position_depends_on_mouse \
			else _target_node.global_position
	
	var my_position: Vector2 = Vector2.ZERO
	if _target_node is Node2D:
		my_position = _target_node.get_global_transform_with_canvas().origin
	elif _target_node is Control:
		my_position = _target_node.position
	
	return my_position


func override_show() -> void:
	_timer.stop()
	show()


func _on_target_mouse_entered() -> void:
	_timer.start()


func _on_target_mouse_exited() -> void:
	_timer.stop()
	override_hide()
