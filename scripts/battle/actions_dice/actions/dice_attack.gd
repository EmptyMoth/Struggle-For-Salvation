class_name DiceAttack
extends AbstractDiceAction


func do(dice_value: int, character: AbstractCharacter, target: AbstractCharacter) -> void:
	var damage: int = character.deal_damage(dice_value)
	target.take_damage(damage)
