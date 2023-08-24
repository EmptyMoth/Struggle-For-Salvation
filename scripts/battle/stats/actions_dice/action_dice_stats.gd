class_name ActionDiceStats
extends Resource


enum DiceType { ATTACK, BLOCK, EVADE, COUNTER }

@export var dice_type: DiceType = DiceType.ATTACK
@export_range(1, 99, 1, "or_greater") var min_value: int = 1
@export_range(1, 99, 1, "or_greater") var max_value: int = 1
@export var action: DiceAction
@export var abilities: Array[BaseActionDiceAbility] = []


func has_ability() -> bool:
	return abilities.size() > 0


func create_dice() -> AbstractActionDice:
	match dice_type:
		DiceType.ATTACK:
			return AttackDice.new(self)
		DiceType.BLOCK:
			return BlockDice.new(self)
		DiceType.EVADE:
			return EvadeDice.new(self)
		_:
			return CounterDice.new(self)
