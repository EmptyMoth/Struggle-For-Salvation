class_name StatusEffectsContiner
extends GridContainer


const _STATUS_EFFECT_INFO_ICON_PACKED: PackedScene = preload("res://scenes/ui/battle/characters_components/status_effect_info_icon.tscn")


func add_status_effect(effect: AbstractStatusEffect) -> void:
	var effect_info_icon: StatusEffectInfoIcon = _STATUS_EFFECT_INFO_ICON_PACKED.instantiate()
	add_child(effect_info_icon)
	effect_info_icon.set_info(effect)
