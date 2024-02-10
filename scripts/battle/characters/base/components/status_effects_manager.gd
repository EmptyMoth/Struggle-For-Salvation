class_name StatusEffectsManager
extends Resource


signal added_status_effect(effect: AbstractStatusEffect)
signal removed_status_effect(effect: AbstractStatusEffect)

var wearer: Character

var status_effects: Dictionary = {}


func _init(character: Character) -> void:
	wearer = character


func add_effect_by_tag(effect_tag: StatusEffectsList.Tags, count: int = 1) -> void:
	var status_effect: AbstractStatusEffect = status_effects.get(effect_tag)
	if status_effect is StackingStatusEffect:
		status_effect.add_stack_count(count)
		return
	_create_effect(effect_tag, count)


func add_effect(effect: AbstractStatusEffect) -> void:
	status_effects[effect.get_tag()] = effect


func reduce_effects_stack() -> void:
	for status_effect: AbstractStatusEffect in status_effects.values():
		if status_effect.is_reduced_in_end_turn:
			status_effect.reduce()


func _create_effect(effect_tag: StatusEffectsList.Tags, count: int) -> void:
	var status_effect: AbstractStatusEffect = \
			StatusEffectsList.GET_STATUS_EFFECT_BY_TAG[effect_tag].new(wearer)
	status_effect.expired.connect(_on_status_effect_expired)
	status_effects[effect_tag] = status_effect
	if status_effect is StackingStatusEffect:
		status_effect.stack_count = count
	added_status_effect.emit(status_effect)


func _on_status_effect_expired(effect: AbstractStatusEffect) -> void:
	removed_status_effect.emit(effect)
	status_effects.erase(effect.get_tag())
