#class_name PlayerInputManager
extends Control


const _PLAYER_ASSAULT_ARROW_PACKED_SCENE: PackedScene = preload("res://scenes/ui/battle/assaults_arrows/player_assault_arrow.tscn")

static var selected_ally_atp_slot: ATPSlot = null
static var selected_skill: AbstractSkill = null

static var _player_assault_arrow: PlayerAssaultArrow


func _input(event: InputEvent) -> void:
	return
	get_viewport().set_input_as_handled()


static func on_ally_atp_slot_deselected(ally_atp_slot: ATPSlot) -> void:
	_deselected()
	if ally_atp_slot.installed_skill != null:
		_remove_assault(ally_atp_slot)


static func on_ally_atp_slot_selected(ally_atp_slot: ATPSlot) -> void:
	selected_ally_atp_slot = ally_atp_slot


static func on_enemy_atp_slot_selected(enemy_atp_slot: ATPSlot) -> void:
	if selected_ally_atp_slot == null or selected_skill == null:
		return
	
	_set_assault(enemy_atp_slot)


static func on_ally_skill_selected(skill: AbstractSkill) -> void:
	if selected_ally_atp_slot == null:
		return
	
	selected_skill = skill
	_player_assault_arrow.show_player_arrow(selected_ally_atp_slot)


static func _deselected() -> void:
	selected_ally_atp_slot = null
	selected_skill = null
	_player_assault_arrow.hide()


static func _set_assault(enemy_atp_slot: ATPSlot) -> void:
	selected_ally_atp_slot.set_skill(selected_skill)
	var targets: Targets = Targets.new(enemy_atp_slot)
	if selected_skill.is_mass_attack():
		var opponent_list: Array[Node] = GlobalParameters.get_nodes_in_group(
			BattleParameters.CHARACTERS_GROUPS_BY_FRACTIONS[BattleEnums.Fraction.ENEMY])
		opponent_list.erase(enemy_atp_slot.wearer)
		targets.sub_targets = selected_skill.choose_sub_targets(opponent_list)
	
	PreparationPhaseManager.set_assault(selected_ally_atp_slot, targets)
	_deselected()


static func _remove_assault(enemy_atp_slot: ATPSlot) -> void:
	selected_ally_atp_slot.remove_skill()
	PreparationPhaseManager.remove_assault(selected_ally_atp_slot)


static func _on_battle_started() -> void:
	_player_assault_arrow = _PLAYER_ASSAULT_ARROW_PACKED_SCENE.instantiate()
	BattleParameters.battle.add_assault_arrow(_player_assault_arrow)

static func _on_battle_ended() -> void:
	_player_assault_arrow.queue_free()
	_player_assault_arrow = null
	_deselected()
