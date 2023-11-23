class_name CharacterCombatModel
extends Resource


signal won_clash(target: Character)
signal drew_clash(target: Character)
signal lost_clash(target: Character)

signal added_to_reserve(action_dice: AbstractActionDice)
signal used_in_one_side(action_dice: AbstractActionDice)
signal used_in_clashed(action_dice: AbstractActionDice)

signal calculated_comparing_value(value: int)
signal used_action_dice(dice: AbstractActionDice)
signal chose_next_action_dice(dice: AbstractActionDice, dice_pool: Array[AbstractActionDice])

var model: Character

var current_atp_slot: ATPSlot = null
var current_skill: AbstractSkill = null
var current_action_dice: AbstractActionDice = null
var dice_reserved_list: ActionDiceReservedList = ActionDiceReservedList.new()

var physical_health: PhysicalHealth
var mental_health: MentalHealth
var physical_resistance: BaseResistance
var mental_resistance: BaseResistance

var is_stunned: bool :
	get: return mental_health.is_empty()
var is_dead: bool :
	get: return physical_health.is_empty()


func _init(character: Character) -> void:
	model = character
	physical_health = PhysicalHealth.new(character.stats.max_physical_health)
	mental_health = MentalHealth.new(character.stats.max_mental_health)
	physical_resistance = BaseResistance.new(character.stats.physical_resistance)
	mental_resistance = BaseResistance.new(character.stats.mental_resistance)


func join_assault(atp_slot: ATPSlot) -> void:
	current_atp_slot = atp_slot
	current_skill = atp_slot.assaulting_skill
	current_skill.combat_model.use()

func finish_assault() -> void:
	current_atp_slot = null
	current_skill = null
	current_action_dice = null


func is_active() -> bool:
	return not is_stunned and not is_dead


func can_continue_assault() -> bool:
	return is_active() and current_skill.combat_model.is_available


func can_fight_back() -> bool:
	return is_active() and dice_reserved_list.there_is_reserved_dice()


func get_next_dice() -> AbstractActionDice:
	if current_skill.combat_model.there_is_dice_available():
		current_action_dice = current_skill.combat_model.get_next_dice()
		chose_next_action_dice.emit(current_action_dice, current_skill.combat_model.get_dice_available())
	else:
		current_action_dice = dice_reserved_list.dequeue()
		chose_next_action_dice.emit(current_action_dice, dice_reserved_list.get_dice())
	return current_action_dice


func calculate_comparing_value(opponent_skill: AbstractSkill) -> int:
	var result: int = opponent_skill.combat_model.calculate_comparing_value(current_skill)
	calculated_comparing_value.emit(result)
	return result


func reserve_current_dice() -> void:
	dice_reserved_list.enqueue(current_action_dice)
	added_to_reserve.emit(current_action_dice)
	await GlobalParameters.get_tree().create_timer(1).timeout


func try_use_current_dice_in_one_side(target: Character) -> void:
	if not is_active():
		return
	current_action_dice.values_model.roll_dice()
	used_action_dice.emit(current_action_dice)
	used_in_one_side.emit(current_action_dice)
	current_action_dice.combat_model.use_in_one_side(target)
	await GlobalParameters.get_tree().create_timer(1).timeout


func try_use_current_dice_in_clash(
			target: Character, clash_result: BattleEnums.ClashResult) -> void:
	if not is_active():
		return
	match clash_result:
		BattleEnums.ClashResult.WIN:
			won_clash.emit(target)
		BattleEnums.ClashResult.LOSE:
			lost_clash.emit(target)
		_:
			drew_clash.emit(target)
	
	used_action_dice.emit(current_action_dice)
	used_in_clashed.emit(current_action_dice)
	current_action_dice.combat_model.use_in_clash(target, clash_result)
	await GlobalParameters.get_tree().create_timer(1).timeout


func to_die() -> void:
	take_physical_damage(model.physical_health.max_health)

func to_stun() -> void:
	take_mental_damage(model.mental_health.max_health)


func take_damage(damage: int, is_permanent: bool = false) -> void:
	take_physical_damage(damage, is_permanent)
	take_mental_damage(damage, is_permanent)

func take_physical_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, physical_resistance, physical_health)

func take_mental_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, mental_resistance, mental_health)


func physical_heal(heal_amound: int) -> void:
	model.physical_health.heal(heal_amound)

func mental_heal(heal_amound: int) -> void:
	model.mental_health.heal(heal_amound)



func _take_damage(damage: int, is_permanent: bool,
			resistance: BaseResistance, health: AbstractHealth) -> int:
	var final_damage: int = damage if is_permanent else roundi(damage * resistance.multiplier)
	health.take_damage(final_damage)
	return final_damage
