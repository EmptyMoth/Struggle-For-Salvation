class_name DiceAttackOnSP
extends AbstractActionDice


func do(dice_value: int, character: AbstractCharacter, target: AbstractCharacter) -> void:
	var damage: int = character.deal_damage(dice_value)
	target.take_mental_damage(damage)
