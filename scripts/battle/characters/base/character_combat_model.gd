class_name CharacterCombatModel
extends Resource


signal won_clash(target: Character)
signal drew_clash(target: Character)
signal lost_clash(target: Character)

var on_move: bool = false

var current_atp_slot: ATPSlot
var current_skill: SkillCombatModel
var current_action_dice: AbstractActionDice
var dice_reserved_list: Array[AbstractActionDice] = []

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


func can_continue_assault() -> bool:
	return is_active() and (current_skill == null or current_skill.is_available)


func can_fight_back() -> bool:
	return there_is_reserved_dice() and is_active()


func there_is_reserved_dice() -> bool:
	return dice_reserved_list.size() > 0


func get_next_dice() -> AbstractActionDice:
	current_action_dice = current_skill.get_next_dice() \
			if current_skill.there_is_dice_available() \
			else dice_reserved_list.pop_front()
	return current_action_dice


func reserve_current_dice() -> void:
	dice_reserved_list.append(current_action_dice)


func try_use_current_dice_in_one_side(target: CharacterCombatModel) -> void:
	if not is_active():
		return
	current_action_dice.use(target)


func try_use_current_dice_in_clash(
			target: CharacterCombatModel, clash_result: BattleEnums.ClashResult) -> void:
	if not is_active():
		return
	current_action_dice.use_in_clash(target, clash_result)


func make_action(action: DiceAction) -> void:
	pass
