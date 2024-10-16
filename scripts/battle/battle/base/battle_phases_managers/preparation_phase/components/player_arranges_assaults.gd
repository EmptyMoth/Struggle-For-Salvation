class_name PlayerArrangeAssaults
extends Node


static var selected_ally_slot: ATPSlot = null
static var selected_skill: Skill = null

static var _player_assault_arrow: PlayerAssaultArrow


func _ready() -> void:
	selected_ally_slot = null
	selected_skill = null
	_player_assault_arrow = PlayerAssaultArrow.create_arrow() as PlayerAssaultArrow


static func select_ally_skill(skill: Skill) -> void:
	if selected_ally_slot == null or skill == null:
		return
	selected_skill = skill
	PlayerState.switch_to_manager()
	_player_assault_arrow.show_arrow(selected_ally_slot)
	_turn_on_manager_mode(true)


static func cancel_ally_assault(atp_slot: ATPSlot) -> void:
	_deselected()
	if atp_slot.assaulting_skill != null:
		AssaultSetter.remove_assault(atp_slot)


static func _deselected() -> void:
	if PlayerState.is_manager():
		_turn_on_manager_mode(false)
	PlayerState.switch_to_default()
	if _player_assault_arrow:
		_player_assault_arrow.hide()
	selected_ally_slot = null
	selected_skill = null


static func _set_assault(enemy_slot: ATPSlot) -> void:
	var targets: Targets = _player_choose_targets(enemy_slot)
	AssaultSetter.create_assault(selected_ally_slot, targets, selected_skill)
	await GlobalParameters.get_tree().process_frame
	PlayerInputManager.player_made_general_cancel.emit()

static func _player_choose_targets(enemy_slot: ATPSlot) -> Targets:
	if not selected_skill.is_mass_attack:
		return Targets.new(enemy_slot)
	var opponent_list: Array[Character] = BattleGroups.get_fraction_group(BattleEnums.Fraction.ENEMY)
	opponent_list.erase(enemy_slot.wearer)
	var sub_targets: Array[ATPSlot] = AutoTargetsSetter.choose_sub_targets(
		opponent_list, selected_skill.targets_count, selected_skill.get_targets_setter())
	return Targets.new(enemy_slot, sub_targets)


static func _turn_on_manager_mode(turn_on: bool) -> void:
	for slot: BaseATPSlotUI in BattleGroups.get_atp_slots_fraction_group(BattleEnums.Fraction.ALLY):
		slot.mouse_filter = Control.MOUSE_FILTER_IGNORE if turn_on else Control.MOUSE_FILTER_STOP
	
	var characters_potentially_involved_in_assaults: Array[Character] = \
			BattleGroups.get_fraction_group(BattleEnums.Fraction.ENEMY)
	characters_potentially_involved_in_assaults.append(selected_ally_slot.wearer)
	#var slots_potentially_involved_in_assaults: Array[BaseATPSlotUI] = \
	#		BattleGroups.get_atp_slots_fraction_group(BattleEnums.Fraction.ENEMY)
	#slots_potentially_involved_in_assaults.append(selected_ally_slot.get_atp_slot_ui())
	#for slot: BaseATPSlotUI in slots_potentially_involved_in_assaults:
	#	slot.mouse_filter = Control.MOUSE_FILTER_STOP
	
	#var selected_stots: Array[CanvasItem] = []
	#selected_stots.assign(slots_potentially_involved_in_assaults)
	BaseBattle.battle.highlight_characters(turn_on)


static func _on_ally_picked(character: Character, atp_slot: ATPSlot = null) -> void:
	if character.is_active and atp_slot != null and Input.is_action_just_released("ui_pick"):
		selected_ally_slot = atp_slot


static func _on_enemy_picked(character: Character, atp_slot: ATPSlot = null) -> void:
	if atp_slot != null and PlayerState.is_manager() and Input.is_action_just_released("ui_pick"):
		_set_assault(atp_slot)


static func _on_character_selected(character: Character, atp_slot: ATPSlot = null) -> void:
	BaseBattle.battle.highlight_characters(true)

static func _on_character_deselected(character: Character, atp_slot: ATPSlot = null) -> void:
	BaseBattle.battle.highlight_characters(false)



static func _on_player_made_general_cancel() -> void: _deselected()

static func _on_battle_preparaion_ended() -> void:
	PlayerInputManager.player_made_general_cancel.emit()
	PlayerState.switch_to_observer()
