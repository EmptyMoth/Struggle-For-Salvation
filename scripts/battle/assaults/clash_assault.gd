class_name ClashAssault
extends AbstractAssault


var _data_2: AssaultData


static func can_be_executed(data: AssaultData) -> bool:
	return super(data) and data.targets.main.assault_can_be_executed()


func _init(assault_data_1: AssaultData, assault_data_2: AssaultData) -> void:
	super(assault_data_1)
	_data_2 = assault_data_2


func _execute() -> void:
	BattleSignals.clash_started.emit(_data.character, _data_2.character)
	while _can_continue_assault():
		await ActionDiceUser.use_dice_in_clash(_data.character, _data_2.character)
	BattleSignals.clash_ended.emit(_data.character, _data_2.character)
	
	if _data.character.combat_model.can_continue_assault():
		await ActionDiceUser.use_dice_in_one_side(_data.character, _data_2.character)
	elif _data.character.combat_model.can_continue_assault():
		await ActionDiceUser.use_dice_in_one_side(_data.character, _data_2.character)


func _move_characters() -> void:
	_data.character.movement_model.move_to_clash(_data_2.character)
	_data_2.character.movement_model.move_to_clash(_data.character)
	await _data_2.character.movement_model.came_to_position


func _join_assault() -> void:
	super()
	_data_2.character.combat_model.join_assault(_data_2.atp_slot)


func _leave_assault() -> void:
	super()
	_data_2.character.combat_model.finish_assault()


func _can_continue_assault() -> bool:
	return (_data.character.combat_model.can_continue_assault() and _data_2.character.combat_model.can_continue_assault()) \
			or (_data.character.combat_model.can_continue_assault() and _data_2.character.combat_model.can_fight_back()) \
			or  (_data.character.combat_model.can_fight_back() and _data_2.character.combat_model.can_continue_assault())
