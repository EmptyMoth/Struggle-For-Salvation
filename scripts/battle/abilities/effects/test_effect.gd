class_name TestStatusEffectEffect
extends AbstractAbilityEffect


var count_effects: int = 0


func get_description() -> String:
	return "Inflict {%s}" % TestStatusEffect.get_keyword()


func effect(_target: Variant = null) -> void:
	if count_effects >= 5:
		return
	_wearer.status_effects_manager.add_effect_by_tag(TestStatusEffect.get_tag(), 1)
	count_effects += 1
