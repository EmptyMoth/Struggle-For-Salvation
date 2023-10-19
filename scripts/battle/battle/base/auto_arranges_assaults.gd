class_name AutoArrangeAssaults
extends RefCounted


static func arranges_enemies() -> void:
	_auto_arranges_characters_assaults(BattleEnums.Fraction.ENEMY, BattleEnums.Fraction.ALLY)

static func arranges_allies() -> void:
	_auto_arranges_characters_assaults(BattleEnums.Fraction.ALLY, BattleEnums.Fraction.ENEMY)


static func _auto_arranges_characters_assaults(
		fraction_characters: BattleEnums.Fraction,
		fraction_opponents: BattleEnums.Fraction) -> void:
	var characters: Array[Node] = BattleParameters.get_fraction_group(fraction_characters)
	var opponents: Array[Node] = BattleParameters.get_fraction_group(fraction_opponents)
	for character in characters:
		var targets_by_atp_slots: Dictionary = character.auto_selecting_assault(opponents)
		for atp_slot in targets_by_atp_slots:
			var targets: Targets = targets_by_atp_slots[atp_slot]
			AssaultSetter.set_assault(atp_slot, atp_slot.installed_skill, targets)
