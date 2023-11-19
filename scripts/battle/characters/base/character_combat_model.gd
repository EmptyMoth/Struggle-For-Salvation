class_name CharacterCombatModel
extends Resource


signal won_clash(target: Character)
signal drew_clash(target: Character)
signal lost_clash(target: Character)

signal added_to_reserve(action_dice: ActionDiceCombatModel)
signal used_in_one_side(action_dice: ActionDiceCombatModel)
signal used_in_clashed(action_dice: ActionDiceCombatModel)

signal calculated_comparing_value(value: int)
signal used_action_dice(dice: AbstractActionDice)
signal chose_next_action_dice(dice: AbstractActionDice, dice_pool: Array[ActionDiceCombatModel])

var model: Character

var current_atp_slot: ATPSlot = null
var current_skill: SkillCombatModel = null
var current_action_dice: ActionDiceCombatModel = null
var dice_reserved_list: ActionDiceReservedList = ActionDiceReservedList.new()


func _init(character: Character) -> void:
	model = character


func _to_string() -> String:
	if current_action_dice == null:
		return model.to_string()
	return " ".join([model.to_string(), "|", current_action_dice.to_string()])


func move_to(opponent: CharacterCombatModel, is_clash: bool) -> void:
	model.character_marker_3d.move_to_assault(opponent.model.character_marker_3d, is_clash)
	await model.character_marker_3d.came_to_position


func join_assault(atp_slot: ATPSlot) -> void:
	current_atp_slot = atp_slot
	current_skill = atp_slot.assaulting_skill.use()

func finish_assault() -> void:
	current_atp_slot = null
	current_skill = null
	current_action_dice = null


func is_active() -> bool:
	return model.is_active()


func can_assault(atp_slot: ATPSlot) -> bool:
	return is_active() and atp_slot.assaulting_skill != null


func can_continue_assault() -> bool:
	return is_active() and current_skill and current_skill.is_available


func can_fight_back() -> bool:
	return is_active() and dice_reserved_list.there_is_reserved_dice()


func get_next_dice() -> ActionDiceCombatModel:
	if current_skill.there_is_dice_available():
		current_action_dice = current_skill.get_next_dice()
		chose_next_action_dice.emit(current_action_dice.model, current_skill.get_dice_available())
	else:
		current_action_dice = dice_reserved_list.dequeue()
		chose_next_action_dice.emit(current_action_dice.model, dice_reserved_list.get_dice())
	return current_action_dice


func calculate_comparing_value(opponent_skill: SkillCombatModel) -> int:
	var result: int = opponent_skill.calculate_comparing_value(current_skill)
	calculated_comparing_value.emit(result)
	return result


func reserve_current_dice() -> void:
	dice_reserved_list.enqueue(current_action_dice)
	added_to_reserve.emit(current_action_dice)


func try_use_current_dice_in_one_side(target: CharacterCombatModel) -> void:
	if not is_active():
		return
	current_action_dice.roll_dice()
	used_action_dice.emit(current_action_dice.model)
	used_in_one_side.emit(current_action_dice)
	current_action_dice.use_in_one_side(target)


func try_use_current_dice_in_clash(
			target: CharacterCombatModel, clash_result: BattleEnums.ClashResult) -> void:
	if not is_active():
		return
	match clash_result:
		BattleEnums.ClashResult.WIN:
			won_clash.emit(target)
		BattleEnums.ClashResult.LOSE:
			lost_clash.emit(target)
		_:
			drew_clash.emit(target)
	
	used_action_dice.emit(current_action_dice.model)
	used_in_clashed.emit(current_action_dice)
	current_action_dice.use_in_clash(target, clash_result)


func make_action(action: DiceAction) -> void:
	pass


func to_die() -> void:
	take_physical_damage(model.physical_health.max_health)

func to_stun() -> void:
	take_mental_damage(model.mental_health.max_health)


func take_damage(damage: int, is_permanent: bool = false) -> void:
	take_physical_damage(damage, is_permanent)
	take_mental_damage(damage, is_permanent)

func take_physical_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, model.physical_resistance, model.physical_health)

func take_mental_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, model.mental_resistance, model.mental_health)


func physical_heal(heal_amound: int) -> void:
	model.physical_health.heal(heal_amound)

func mental_heal(heal_amound: int) -> void:
	model.mental_health.heal(heal_amound)



func _take_damage(damage: int, is_permanent: bool,
			resistance: BaseResistance, health: AbstractHealth) -> int:
	var final_damage: int = damage if is_permanent else roundi(damage * resistance.multiplier)
	health.take_damage(final_damage)
	return final_damage
