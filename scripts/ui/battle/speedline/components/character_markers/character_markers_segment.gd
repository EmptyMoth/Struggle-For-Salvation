extends HBoxContainer


const _CHARACTER_MARKER_PACKED: PackedScene = preload("res://scenes/ui/battle/speedline/components/character_markers/character_speedline_marker.tscn")


func set_atp_slots(atp_slots: Array[ATPSlot]) -> void:
	for atp_slot: ATPSlot in atp_slots:
		var character_marker: MarginContainer = _CHARACTER_MARKER_PACKED.instantiate()
		add_child(character_marker)
		character_marker.set_atp_slot(atp_slot)
