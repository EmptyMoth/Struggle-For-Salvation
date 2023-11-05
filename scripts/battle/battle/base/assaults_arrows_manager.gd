class_name AssaultsArrowsManager
extends RefCounted


static var _arrows_list_by_atp_slot: Dictionary = {}


static func create_arrows(assault: AssaultData) -> void:
	_create_assault_arrow(assault, assault.targets.main)
	for sub_target_atp in assault.targets.sub_targets:
		_create_assault_arrow(assault, sub_target_atp)


static func remove_arrows(assault: AssaultData) -> void:
	var arrows_list: Array[BaseAssaultArrow] = _get_arrows_list(assault.atp_slot)
	for arrow in arrows_list:
		BattleParameters.battle.remove_assault_arrow(arrow)
	arrows_list.clear()


static func toggle_arrows_by_atp_slot(atp_slot: ATPSlot, display: bool) -> void:
	for arrow in _get_related_arrows_list(atp_slot):
		arrow.toggle_fix(display)

static func show_arrows_by_atp_slot(atp_slot: ATPSlot) -> void:
	for arrow in _get_related_arrows_list(atp_slot):
		arrow.show()

static func hide_arrows_by_atp_slot(atp_slot: ATPSlot) -> void:
	for arrow in _get_related_arrows_list(atp_slot):
		arrow.hide_arrow()


static func display_allies_arrows(display: bool) -> void:
	_display_arrows(BattleGroups.get_assault_arrows_group(
			BaseAssaultArrow.AssaultArrowType.ALLY_ONE_SIDE), display)

static func display_enemies_arrows(display: bool) -> void:
	_display_arrows(BattleGroups.get_assault_arrows_group(
			BaseAssaultArrow.AssaultArrowType.ENEMY_ONE_SIDE), display)

static func display_clashes_arrows(display: bool) -> void:
	_display_arrows(BattleGroups.get_assault_arrows_group(
			BaseAssaultArrow.AssaultArrowType.CLASH), display)


static func _get_arrows_list(atp_slot: ATPSlot) -> Array[BaseAssaultArrow]:
	return _arrows_list_by_atp_slot.get(atp_slot, [] as Array[BaseAssaultArrow])

static func _get_related_arrows_list(atp_slot: ATPSlot) -> Array[BaseAssaultArrow]:
	var arrows: Array[BaseAssaultArrow] = _get_arrows_list(atp_slot).duplicate()
	for targeting_assault in AssaultLog.get_assaults_targeting(atp_slot):
		arrows.append_array(_get_arrows_list(targeting_assault.atp_slot))
	return arrows


static func _display_arrows(arrows: Array, display: bool) -> void:
	for arrow in arrows:
		arrow.is_battle_setting_display = display


static func _create_assault_arrow(assault: AssaultData, target_atp_slot: ATPSlot) -> void:
	var arrow: BaseAssaultArrow = BaseAssaultArrow.create_arrow(assault, target_atp_slot)
	var arrows_list: Array[BaseAssaultArrow] = _get_arrows_list(assault.atp_slot)
	arrows_list.append(arrow)
	_arrows_list_by_atp_slot[assault.atp_slot] = arrows_list
	BattleParameters.battle.add_assault_arrow(arrow)
