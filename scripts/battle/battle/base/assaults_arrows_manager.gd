class_name AssaultsArrowsManager
extends RefCounted


const _ARROW_PACKED_SCENE: PackedScene = preload("res://scenes/ui/battle/assaults_arrows/base/base_assault_arrow.tscn")

static var _allies_arrows: Array[BaseAssaultArrow] = []
static var _enemies_arrows: Array[BaseAssaultArrow] = []
static var _clashes_arrows: Array[BaseAssaultArrow] = []
static var _arrows_list_by_atp_slot: Dictionary = {}


static func create_arrows(assault: AssaultData) -> void:
	_create_assault_arrow(assault.atp_slot)
	for sub_target_atp in assault.targets.sub_targets:
		_create_assault_arrow(sub_target_atp)


static func remove_arrows(assault: AssaultData) -> void:
	_get_arrows_list(assault.atp_slot).clear()


static func show_arrows_by_atp_slot(atp_slot: ATPSlot) -> void:
	var assault: AssaultData = AssaultLog.get_assault(atp_slot)
	if assault != null:
		_show_arrows_by_atp_slot(assault)
	for targeting_assault in AssaultLog.get_assaults_targeting(atp_slot):
		_show_arrows_by_atp_slot(targeting_assault)


static func hide_arrows_by_atp_slot(atp_slot: ATPSlot) -> void:
	var arrows: Array[BaseAssaultArrow] = _get_arrows_list(atp_slot).duplicate()
	for targeting_assault in AssaultLog.get_assaults_targeting(atp_slot):
		arrows.append_array(_get_arrows_list(targeting_assault.atp_slot))
	
	for arrow in arrows:
		arrow.hide()


static func display_allies_arrows(display: bool) -> void:
	_display_arrows(_allies_arrows, display)


static func display_enemies_arrows(display: bool) -> void:
	_display_arrows(_enemies_arrows, display)


static func display_clashes_arrows(display: bool) -> void:
	_display_arrows(_clashes_arrows, display)


static func _get_arrows_list(atp_slot: ATPSlot) -> Array[BaseAssaultArrow]:
	return _arrows_list_by_atp_slot.get(atp_slot, [] as Array[BaseAssaultArrow])


static func _display_arrows(arrows: Array[BaseAssaultArrow], display: bool) -> void:
	for arrow in arrows:
		arrow.visible = display


static func _show_arrows_by_atp_slot(assault: AssaultData) -> void:
	var arrow: BaseAssaultArrow = _get_arrows_list(assault.atp_slot).back()
	arrow.show_arrow(assault, assault.targets.main)
	for i in assault.targets.sub_targets.size():
		var sub_target: ATPSlot = assault.targets.sub_targets[i]
		arrow = _get_arrows_list(assault.atp_slot)[i]
		arrow.show_arrow(assault, sub_target)


static func _create_assault_arrow(atp_slot: ATPSlot) -> void:
	var arrow: BaseAssaultArrow = _ARROW_PACKED_SCENE.instantiate()
	var arrows_list: Array[BaseAssaultArrow] = _get_arrows_list(atp_slot)
	arrows_list.append(arrow)
	_arrows_list_by_atp_slot[atp_slot] = arrows_list
	BattleParameters.battle.add_assault_arrow(arrow)
