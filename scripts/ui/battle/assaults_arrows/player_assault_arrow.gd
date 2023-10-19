class_name PlayerAssaultArrow
extends BaseAssaultArrow


func _ready() -> void:
	hide()
	_arrow_type == AssaultArrowType.PLAYER
	modulate = COLOR_BY_ARROW_TYPE[_arrow_type]


static func create_arrow() -> BaseAssaultArrow:
	var assault_arrow_scene: BaseAssaultArrow = super()
	assault_arrow_scene.set_script(PlayerAssaultArrow)
	return assault_arrow_scene


func show_arrow(atp_slot: ATPSlot, _target_atp_slot: ATPSlot = null) -> void:
	_atp_slot = atp_slot.get_atp_slot_ui()
	show()


func _get_target_point() -> Vector2:
	return get_global_mouse_position()
