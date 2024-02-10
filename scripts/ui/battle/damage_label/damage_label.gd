class_name DamageLabel
extends HBoxContainer


const _PACKED_SCENE: PackedScene = preload("res://scenes/ui/battle/damage_label/damage_label.tscn")


func _ready() -> void:
	animate_label.call_deferred()


func animate_label() -> void:
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_parallel(true)
	tween.tween_property(self, "position:x", position.x - randi_range(-1, 1) * randi_range(75, 100), 0.75).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", position.y - randi_range(50, 100), 0.75).set_ease(Tween.EASE_OUT)
	#tween.tween_property(self, "position:y", position.y, 0.5).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(self, "modulate:a", 0.0, 0.25).set_ease(Tween.EASE_IN).set_delay(0.5)
	await tween.finished
	queue_free()


static func create_damage_label(damage_info: DamageInfo) -> DamageLabel:
	var label: DamageLabel = _PACKED_SCENE.instantiate()
	label.get_node("DamageCount").text = str(damage_info.damage_received)
	var resistance: Variant = BaseResistance.ResistanceType.find_key(damage_info.resistance)
	label.get_node("TypeResistance").text = "" if resistance == null else resistance.to_camel_case()
	label.scale = damage_info.dice_gain_multiplier * Vector2.ONE
	label.modulate = _get_color_by_type(damage_info.damage_type)
	return label


static func _get_color_by_type(type: BattleEnums.DamageType) -> Color:
	match type:
		BattleEnums.DamageType.PHYSICAL:
			return Color("E55050")
		BattleEnums.DamageType.MENTAL:
			return Color("509BE5")
		_:
			return Color.WHITE_SMOKE
