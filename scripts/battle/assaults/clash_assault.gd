class_name ClashAssault
extends AbstractAssault


var _defendant_info: CharacterAssaultInfo


func _init(assault_data_1: AssaultData, assault_data_2: AssaultData) -> void:
	super(assault_data_1)
	_defendant_info = CharacterAssaultInfo.new(assault_data_2)


static func can_be_executed(data: AssaultData) -> bool:
	return super(data) and data.targets.main.assault_can_be_executed()


func _execute() -> void:
	BattleSignals.clash_started.emit(_initiator_info.character, _defendant_info.character)
	while _can_continue_assault():
		await ActionDiceUseManager.use_dice_in_clash(_initiator_info, _defendant_info)
	BattleSignals.clash_ended.emit(_initiator_info.character, _defendant_info.character)
	
	while _initiator_info.character.combat_model.can_continue_assault():
		await ActionDiceUseManager.use_dice_in_one_side(_initiator_info)
	while _initiator_info.character.combat_model.can_continue_assault():
		await ActionDiceUseManager.use_dice_in_one_side(_initiator_info)


func _move_characters() -> void:
	_initiator_info.character.movement_model.move_to_clash(_defendant_info.character)
	_defendant_info.character.movement_model.move_to_clash(_initiator_info.character)
	await _defendant_info.character.movement_model.came_to_position


func _join_assault() -> void:
	super()
	_defendant_info.character.combat_model.join_assault(_defendant_info.attacker_atp_slot)


func _leave_assault() -> void:
	super()
	_defendant_info.character.combat_model.finish_assault()


func _can_continue_assault() -> bool:
	var initiator: CharacterCombatModel = _initiator_info.character.combat_model
	var defendant: CharacterCombatModel = _defendant_info.character.combat_model
	var condition: Callable = func(character: Character) -> bool: return not character.is_dead
	return  _initiator_info.opponents.get_all_opponents().any(condition) \
			and _defendant_info.opponents.get_all_opponents().any(condition) \
			and ((initiator.can_continue_assault() and defendant.can_continue_assault()) \
			or (initiator.can_continue_assault() and defendant.can_fight_back()) \
			or  (initiator.can_fight_back() and defendant.can_continue_assault()))
