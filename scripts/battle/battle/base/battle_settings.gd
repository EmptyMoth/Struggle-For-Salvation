class_name BattleSettings
extends RefCounted


static var is_display_allied_arrows: bool = false :
	set(display):
		is_display_allied_arrows = display
		AssaultsArrowsManager.display_allies_arrows(display)
static var is_display_enemy_arrows: bool = false :
	set(display):
		is_display_enemy_arrows = display
		AssaultsArrowsManager.display_enemies_arrows(display)
static var is_display_clashing_arrows: bool = false :
	set(display):
		is_display_clashing_arrows = display
		AssaultsArrowsManager.display_clashes_arrows(display)


static func get_display_assault_arrows_by_type(
			arrow_type: BaseAssaultArrow.AssaultArrowType) -> bool:
	match arrow_type:
		BaseAssaultArrow.AssaultArrowType.CLASH:
			return is_display_clashing_arrows
		BaseAssaultArrow.AssaultArrowType.ALLY_ONE_SIDE:
			return is_display_allied_arrows
		_:
			return is_display_enemy_arrows
