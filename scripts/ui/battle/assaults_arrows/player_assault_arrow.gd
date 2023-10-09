class_name PlayerAssaultArrow
extends BaseAssaultArrow


func _ready() -> void:
	hide()
	_get_target_point = func(): return get_global_mouse_position()


func show_player_arrow(atp_slot: ATPSlot) -> void:
	_atp_slot = atp_slot
	show()
