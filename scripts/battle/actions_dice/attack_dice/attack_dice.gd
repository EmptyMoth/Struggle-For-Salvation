class_name AttackDice
extends AbstractActionDice


func _ready() -> void:
	dice_type = DiceType.ATTACK_DICE


func _winning_a_clash(dice_type: AbstractActionDice.DiceType, dice_value: int) -> void:
	match dice_type:
		DiceType.ATTACK_DICE, DiceType.COUNTER_ATTACK_DICE:
			pass
		DiceType.BLOCK_DICE, DiceType.COUNTER_BLOCK_DICE:
			pass
		DiceType.EVADE_DICE, DiceType.COUNTER_EVADE_DICE:
			pass


func _drawing_a_clash(dice_type: AbstractActionDice.DiceType, dice_value: int) -> void:
	match dice_type:
		DiceType.ATTACK_DICE, DiceType.COUNTER_ATTACK_DICE:
			_break_dice()
		DiceType.BLOCK_DICE, DiceType.COUNTER_BLOCK_DICE:
			pass
		DiceType.EVADE_DICE, DiceType.COUNTER_EVADE_DICE:
			pass


func _losing_a_clash(dice_type: AbstractActionDice.DiceType, dice_value: int) -> void:
	match dice_type:
		DiceType.ATTACK_DICE, DiceType.COUNTER_ATTACK_DICE:
			_break_dice()
		DiceType.BLOCK_DICE, DiceType.COUNTER_BLOCK_DICE:
			pass
		DiceType.EVADE_DICE, DiceType.COUNTER_EVADE_DICE:
			pass
