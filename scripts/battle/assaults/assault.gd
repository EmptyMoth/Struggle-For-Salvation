#class_name Assault
extends Resource


signal executed

var _assault_data: AssaultData

var _character: Character
var _target: Character
var _character_skill: SkillCombatModel
var _target_skill: SkillCombatModel
var _currect_character_action_dice: AbstractActionDice
var _currect_target_action_dice: AbstractActionDice


func _init(assault_data: AssaultData) -> void:
	_assault_data = assault_data


#func execute() -> void:
#	_character = atp_slot.wearer
#	_target = targets.main.wearer
#	if type == BattleEnums.AssaultType.CLASH and _target.is_stunned:
#		type = BattleEnums.AssaultType.ONE_SIDE
#
#	match type:
#		BattleEnums.AssaultType.ONE_SIDE:
#			_make_one_side_assault()
#		_:
#			_make_clash_assault() 
#
#	executed.emit()


func _make_one_side_assault() -> void:
	_character.character_marker_3d.move_to_one_sided(_target.character_marker_3d)
	await _character.character_marker_3d.came_to_position
	var skill: SkillCombatModel = _character.get_skill_used()
	for i in skill.get_dice_count():
		var action_dice: AbstractActionDice = skill.get_next_dice()
		var target_dice_reserved: AbstractActionDice = _target.get_next_dice_reserved()
		if target_dice_reserved != null:
			_make_dice_clash_assault()
			continue
		_make_dice_one_side_assault()


func _make_clash_assault() -> void:
	_character.character_marker_3d.move_to_clash(_target.character_marker_3d)
	_target.character_marker_3d.move_to_clash(_character.character_marker_3d)
	while _character.on_move or _target.on_move:
		pass
	
	_character_skill = _character.get_skill_used()
	_target_skill = _target.get_skill_used()
	for i in max(_character_skill.get_dice_count(), _target_skill.get_dice_count()):
		_currect_character_action_dice = _character_skill.get_next_dice()
		_currect_target_action_dice = _target_skill.get_next_dice()
		_currect_character_action_dice = _character_skill.get_next_dice_reserved() \
				if _currect_character_action_dice == null \
				else _currect_character_action_dice
		_currect_target_action_dice = _target_skill.get_next_dice_reserved() \
				if _currect_target_action_dice == null \
				else _currect_target_action_dice
		if _currect_character_action_dice == null:
			_make_dice_one_side_assault()
		elif _currect_target_action_dice == null:
			_make_dice_one_side_assault()
		else:
			_make_dice_clash_assault()


func _make_dice_one_side_assault() -> void:
	_currect_character_action_dice.roll_dice()
	var action: DiceAction = _currect_character_action_dice.use_on_one_side()
	action.execute(_character, _target)
	await action.finished


func _make_dice_clash_assault() -> void:
	_currect_character_action_dice.roll_dice()
	_currect_target_action_dice.roll_dice()
	@warning_ignore("int_as_enum_without_cast")
	var character_result: BattleEnums.ClashResult = clampi(
			_currect_character_action_dice.get_current_value() \
			- _currect_target_action_dice.get_current_value(), \
			-1, 1)
	@warning_ignore("int_as_enum_without_cast")
	var target_result: BattleEnums.ClashResult = -character_result
	var character_action: DiceAction = _currect_character_action_dice.use_on_clash(
			_currect_target_action_dice, character_result)
	var target_action: DiceAction = _currect_target_action_dice.use_on_clash(
			_currect_character_action_dice, target_result)
	character_action.execute(_character, _target)
	target_action.execute(_target, _character)
	while character_action.is_executing or target_action.is_executing:
		pass
