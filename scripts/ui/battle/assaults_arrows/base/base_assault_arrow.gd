class_name BaseAssaultArrow
extends Control


enum AssaultArrowType {
	PLAYER,
	ALLY_ONE_SIDE,
	ENEMY_ONE_SIDE,
	CLASH,
}

const COLOR_BY_ARROW_TYPE: Dictionary = {
	AssaultArrowType.PLAYER : Color("f5f5f5"),
	AssaultArrowType.ALLY_ONE_SIDE : Color("69b6d9"),
	AssaultArrowType.ENEMY_ONE_SIDE : Color("ff6a6e"),
	AssaultArrowType.CLASH : Color("ffe869"),
}

const _ASSAULT_ARROW_PACKED_SCENE: PackedScene = preload("res://scenes/ui/battle/assaults_arrows/base/base_assault_arrow.tscn")

var _arrow_type: AssaultArrowType
var _atp_slot: BaseATPSlotUI
var _target_atp_slot: BaseATPSlotUI

@onready var _body: BodyOfAssaultArrow = $Body
@onready var _pointer: PointerOfAssaultArrow = $Pointer


func _ready() -> void:
	hide()


func _process(delta: float) -> void:
	if visible:
		_draw_arrow()


static func create_arrow() -> BaseAssaultArrow:
	return _ASSAULT_ARROW_PACKED_SCENE.instantiate()


func show_arrow(atp_slot: ATPSlot, target_atp_slot: ATPSlot) -> void:
	var assault: AssaultData = AssaultLog.get_assault(atp_slot)
	_atp_slot = atp_slot.get_atp_slot_ui()
	_target_atp_slot = target_atp_slot.get_atp_slot_ui()
	var is_sub_arrow: bool = assault.targets.main != target_atp_slot
	_arrow_type = _determine_arrow_type(assault, is_sub_arrow)
	modulate = COLOR_BY_ARROW_TYPE[_arrow_type]
	_create_body_arrow(is_sub_arrow)
	show()


func _draw_arrow() -> void:
	var initional_point: Vector2 = _atp_slot.center_position
	var initional_target_point: Vector2 = _get_target_point()
	var arrow_line: Vector2 = initional_target_point - initional_point
	_body.set_arrow_line(arrow_line)

	var weight: float = 0.5 if _arrow_type == AssaultArrowType.CLASH else 1.0
	var angle_along_body: float = _body.get_angle_along_body(weight)

	_pointer.draw(_body.get_point_on_arc(weight), angle_along_body)
	_body.draw(_pointer.connection_point)
	angle_along_body = _body.get_adjusted_angle_along_body()
	_pointer.adjust(angle_along_body)

	position = initional_point
	rotation = arrow_line.angle()


func _get_target_point() -> Vector2:
	return _target_atp_slot.center_position


func _determine_arrow_type(assault: AssaultData, is_sub_arrow: bool) -> AssaultArrowType:
	if not is_sub_arrow and assault.is_clash():
		return AssaultArrowType.CLASH
	return AssaultArrowType.ALLY_ONE_SIDE \
			if assault.atp_slot.wearer.is_ally \
			else AssaultArrowType.ENEMY_ONE_SIDE


func _create_body_arrow(is_sub_arrow: bool) -> void:
	pass
