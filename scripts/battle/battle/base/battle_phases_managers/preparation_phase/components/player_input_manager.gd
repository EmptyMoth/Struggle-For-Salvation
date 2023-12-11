#class_name PlayerInputManager
extends Control


signal player_made_general_cancel

signal ally_picked(character: Character, atp_slot: ATPSlot)
signal ally_selected(character: Character, atp_slot: ATPSlot)
signal ally_deselected(character: Character, atp_slot: ATPSlot)

signal enemy_picked(character: Character, atp_slot: ATPSlot)
signal enemy_selected(character: Character, atp_slot: ATPSlot)
signal enemy_deselected(character: Character, atp_slot: ATPSlot)

static var selected_ally_slot: ATPSlot = null
static var selected_skill: Skill = null

static var _player_assault_arrow: PlayerAssaultArrow


func _ready() -> void:
	ally_picked.connect(_on_ally_picked)
	enemy_picked.connect(_on_enemy_picked)


func _input(_event: InputEvent) -> void:
	if BaseBattle.battle == null:
		return
	if BaseBattle.battle.current_phase != BattleEnums.BattlePhase.PREPARATION:
		return
	if Input.is_action_just_released("ui_switch_battle_phase"):
		PreparationPhaseManager.finish_phase()
	
	if Input.is_action_just_released("ui_auto_set_assault"):
		AutoArrangeAssaults.arranges_allies()
	
	if Input.is_action_just_released("ui_show_one_side_allied_arrows"):
		BattleSettings.is_display_allied_arrows = not BattleSettings.is_display_allied_arrows
	elif Input.is_action_just_released("ui_show_one_side_enemy_arrows"):
		BattleSettings.is_display_enemy_arrows = not BattleSettings.is_display_enemy_arrows
	elif Input.is_action_just_released("ui_show_clashing_arrows"):
		BattleSettings.is_display_clashing_arrows = not BattleSettings.is_display_clashing_arrows
#	get_viewport().set_input_as_handled()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		player_made_general_cancel.emit()
		_deselected()


func get_character_picked_signal(character_is_ally: bool) -> Signal:
	return ally_picked if character_is_ally else enemy_picked

func get_character_selected_signal(character_is_ally: bool) -> Signal:
	return ally_selected if character_is_ally else enemy_selected

func get_character_deselected_signal(character_is_ally: bool) -> Signal:
	return ally_deselected if character_is_ally else enemy_deselected


static func on_ally_skill_selected(skill: Skill) -> void:
	if selected_ally_slot == null:
		return
	selected_skill = skill
	_player_assault_arrow.show_arrow(selected_ally_slot)


static func _deselected() -> void:
	selected_ally_slot = null
	selected_skill = null
	_player_assault_arrow.hide()


static func _set_assault(enemy_slot: ATPSlot) -> void:
	var targets: Targets = Targets.new(enemy_slot)
	if selected_skill.is_mass_attack:
		var opponent_list: Array[Character] = BattleGroups.get_fraction_group(BattleEnums.Fraction.ENEMY)
		opponent_list.erase(enemy_slot.wearer)
		targets.sub_targets = AutoTargetsSetter.choose_sub_targets(
				opponent_list, selected_skill.targets_count, selected_skill.get_targets_setter())
	
	AssaultSetter.create_assault(selected_ally_slot, targets, selected_skill)
	PlayerInputManager.player_made_general_cancel.emit()
	_deselected()


static func _on_ally_picked(_characte: Character, atp_slot: ATPSlot = null) -> void:
	if Input.is_action_just_released("ui_pick"):
		selected_ally_slot = atp_slot
	elif Input.is_action_just_released("ui_cancel"):
		_deselected()
		if atp_slot.assaulting_skill != null:
			AssaultSetter.remove_assault(atp_slot)

static func _on_enemy_picked(_characte: Character, atp_slot: ATPSlot = null) -> void:
	if Input.is_action_just_released("ui_pick"):
		if selected_ally_slot != null and selected_skill != null:
			_set_assault(atp_slot)


static func _on_battle_started() -> void:
	_player_assault_arrow = PlayerAssaultArrow.create_arrow() as PlayerAssaultArrow
	BattleParameters.battle.add_assault_arrow(_player_assault_arrow)

static func _on_battle_ended() -> void:
	_player_assault_arrow.queue_free()
	_player_assault_arrow = null
	_deselected()
