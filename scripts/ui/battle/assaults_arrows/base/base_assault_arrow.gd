class_name BaseAssaultArrow
extends Control


var _atp_slot: ATPSlot
var _get_target_point: Callable

@onready var _body: BodyOfAssaultArrow = $Body
@onready var _pointer: PointerOfAssaultArrow = $Pointer


func _ready() -> void:
	hide()


func _process(_delta: float) -> void:
	if visible:
		_draw_arrow()


func show_arrow(assault: AssaultData, target_atp_slot: ATPSlot) -> void:
	_atp_slot = assault.atp_slot
	var is_sub_arrow: bool = assault.targets.main != target_atp_slot
	if not is_sub_arrow and assault.is_clash():
		_create_clash_arrow(target_atp_slot)
	elif _atp_slot.wearer.is_ally:
		_create_ally_arrow(target_atp_slot, is_sub_arrow)
	else:
		_create_enemy_arrow(target_atp_slot, is_sub_arrow)
	
	show()


func show_player_arrow(atp_slot: ATPSlot) -> void:
	_atp_slot = atp_slot
	_get_target_point = func(): return get_global_mouse_position()
	show()


func _get_center_position_atp_slot(atp_slot: ATPSlot) -> Vector2:
	var atp_slot_ui: BaseATPSlotUI = atp_slot.get_atp_slot_ui()
	return atp_slot_ui.global_position + atp_slot_ui.size / 2


func _draw_arrow() -> void:
	var initional_position: Vector2 = _get_center_position_atp_slot(_atp_slot)
	var target_point: Vector2 = _get_target_point.call()
	_pointer.draw(initional_position, target_point)
	var connection_point: Vector2 = _pointer.get_connection_point()
	_body.draw(initional_position, connection_point)


func _create_ally_arrow(target_atp_slot: ATPSlot, is_sub_arrow: bool) -> void:
	modulate = Color("69b6d9")
	_create_one_side_arrow(target_atp_slot, is_sub_arrow)


func _create_enemy_arrow(target_atp_slot: ATPSlot, is_sub_arrow: bool) -> void:
	modulate = Color("ff6a6e")
	_create_one_side_arrow(target_atp_slot, is_sub_arrow)


func _create_one_side_arrow(target_atp_slot: ATPSlot, is_sub_arrow: bool) -> void:
	_get_target_point = _get_center_position_atp_slot.bind(target_atp_slot)


func _create_clash_arrow(target_atp_slot: ATPSlot) -> void:
	modulate = Color("ffe869")
	var atp_slot_ui: BaseATPSlotUI = _atp_slot.get_atp_slot_ui()
	var target_atp_slot_ui: BaseATPSlotUI = target_atp_slot.get_atp_slot_ui()
	_get_target_point = func(): 
			return (atp_slot_ui.global_position + target_atp_slot_ui.global_position) / 2
