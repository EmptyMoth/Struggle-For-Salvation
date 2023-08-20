class_name DiceHealingSP
extends AbstractActionDice


func do(dice_value: int, character: AbstractCharacter, _target: AbstractCharacter) -> void:
	character.mental_health.heal(dice_value)
