class_name BaseAssaultArrow
extends Control


enum AssaultArrowType {
	PLAYER = -1,
	ALLY_ONE_SIDE = 0,
	ENEMY_ONE_SIDE = 1,
	CLASH = 2,
}

const COLOR_BY_ARROW_TYPE: Dictionary = {
	AssaultArrowType.PLAYER : Color("f5f5f5"),
	AssaultArrowType.ALLY_ONE_SIDE : Color("65B5FF"),
	AssaultArrowType.ENEMY_ONE_SIDE : Color("FF5454"),
	AssaultArrowType.CLASH : Color("FFE76A"),
}

const _ASSAULT_ARROW_PACKED_SCENE: PackedScene = preload("res://scenes/ui/battle/assaults_arrows/base/base_assault_arrow.tscn")

var is_battle_setting_display: bool = false :
	set(display):
		is_battle_setting_display = display
		visible = display or is_fixed
var is_fixed: bool = false :
	get: return _fixed_count > 0
var is_sub_arrow: bool = false

var _arrow_type: AssaultArrowType
var _fixed_count: int = 0

var _atp_slot: BaseATPSlotUI
var _target_atp_slot: BaseATPSlotUI

@onready var _body: BodyOfAssaultArrow = $Body
@onready var _pointer: PointerOfAssaultArrow = $Pointer


func init(assault: AssaultData, target_atp_slot: ATPSlot) -> void:
	hide()
	_atp_slot = assault.atp_slot.get_atp_slot_ui()
	_update_arrow(assault, target_atp_slot)
	assault.assault_data_changed.connect(_on_assault_data_changed)


func _process(_delta: float) -> void:
	if visible:
		_draw_arrow()


static func create_arrow(assault: AssaultData, target_atp_slot: ATPSlot) -> BaseAssaultArrow:
	var arrow: BaseAssaultArrow = _ASSAULT_ARROW_PACKED_SCENE.instantiate()
	arrow.init(assault, target_atp_slot)
	return arrow


func toggle_fix(display: bool) -> void:
	_fixed_count += 1 if display else -1


func hide_arrow() -> void:
	if not is_fixed and not is_battle_setting_display:
		hide()


func _update_arrow(assault: AssaultData, target_atp_slot: ATPSlot) -> void:
	_target_atp_slot = target_atp_slot.get_atp_slot_ui()
	is_sub_arrow = target_atp_slot != assault.targets.main 
	remove_from_group(BattleGroups.GROUPS_BY_ASSAULT_ARROWS_TYPES[_arrow_type])
	_arrow_type = _determine_arrow_type(assault)
	add_to_group(BattleGroups.GROUPS_BY_ASSAULT_ARROWS_TYPES[_arrow_type])
	is_battle_setting_display = BattleSettings.get_display_assault_arrows_by_type(_arrow_type)
	modulate = COLOR_BY_ARROW_TYPE[_arrow_type]
	if not is_node_ready():
		await ready
	_body.change_appearance(is_sub_arrow)


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


func _determine_arrow_type(assault: AssaultData) -> AssaultArrowType:
	if not is_sub_arrow and assault.is_clash():
		return AssaultArrowType.CLASH
	return AssaultArrowType.ALLY_ONE_SIDE \
			if assault.atp_slot.wearer.is_ally \
			else AssaultArrowType.ENEMY_ONE_SIDE


func _on_assault_data_changed(changed_assault: AssaultData) -> void:
	var current_target: ATPSlot = _target_atp_slot.model
	if current_target == changed_assault.targets.default_main \
			or current_target == changed_assault.targets.main \
			or not is_sub_arrow:
		_update_arrow(changed_assault, changed_assault.targets.main)
