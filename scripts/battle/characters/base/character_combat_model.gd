class_name CharacterCombatModel
extends Resource


signal won_clash(target: Character)
signal drew_clash(target: Character)
signal lost_clash(target: Character)

var current_atp_slot: ATPSlot = null
var current_skill: SkillCombatModel = null
var current_action_dice: AbstractActionDice = null
var dice_reserved_list: ActionDiceReservedList = ActionDiceReservedList.new()

var wearer: Character


func _init(character: Character) -> void:
	wearer = character


func _to_string() -> String:
	return wearer.to_string()


func move_to(opponent: CharacterCombatModel, is_clash: bool) -> void:
	wearer.character_marker_3d.move_to_assault(opponent.wearer.character_marker_3d, is_clash)
	await wearer.character_marker_3d.came_to_position


func join_assault(atp_slot: ATPSlot) -> void:
	current_atp_slot = atp_slot
	current_skill = atp_slot.assaulting_skill.use()

func finish_assault() -> void:
	current_atp_slot = null
	current_skill = null
	current_action_dice = null


func is_active() -> bool:
	return wearer.is_active()


func can_assault(atp_slot: ATPSlot) -> bool:
	return is_active() and atp_slot.assaulting_skill != null


func can_continue_assault() -> bool:
	return is_active() and current_skill and current_skill.is_available


func can_fight_back() -> bool:
	return is_active() and dice_reserved_list.there_is_reserved_dice()


func get_next_dice() -> AbstractActionDice:
	current_action_dice = current_skill.get_next_dice() \
			if current_skill.there_is_dice_available() \
			else dice_reserved_list.dequeue()
	return current_action_dice


func reserve_current_dice() -> void:
	print("Dice added in Reserve")
	dice_reserved_list.enqueue(current_action_dice)


func try_use_current_dice_in_one_side(target: CharacterCombatModel) -> void:
	if not is_active():
		return
	print("Use One-side")
	current_action_dice.roll_dice()
	current_action_dice.use(target)


func try_use_current_dice_in_clash(
			target: CharacterCombatModel, clash_result: BattleEnums.ClashResult) -> void:
	if not is_active():
		return
	print("Use Clash")
	match clash_result:
		BattleEnums.ClashResult.WIN:
			won_clash.emit(target)
		BattleEnums.ClashResult.LOSE:
			lost_clash.emit(target)
		_:
			drew_clash.emit(target)
	
	current_action_dice.use_in_clash(target, clash_result)


func make_action(action: DiceAction) -> void:
	pass


func to_die() -> void:
	take_physical_damage(wearer.physical_health.max_health)

func to_stun() -> void:
	take_mental_damage(wearer.mental_health.max_health)


func take_damage(damage: int, is_permanent: bool = false) -> void:
	take_physical_damage(damage, is_permanent)
	take_mental_damage(damage, is_permanent)

func take_physical_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, wearer.physical_resistance, wearer.physical_health)

func take_mental_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, wearer.mental_resistance, wearer.mental_health)


func physical_heal(heal_amound: int) -> void:
	wearer.physical_health.heal(heal_amound)

func mental_heal(heal_amound: int) -> void:
	wearer.mental_health.heal(heal_amound)



func _take_damage(damage: int, is_permanent: bool,
			resistance: BaseResistance, health: AbstractHealth) -> int:
	var final_damage: int = damage if is_permanent else roundi(damage * resistance.multiplier)
	health.take_damage(final_damage)
	return final_damage
