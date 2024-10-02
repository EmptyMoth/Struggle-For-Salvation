class_name SpeedlinePanel
extends MarginContainer


const _CHARACTERS_MARKERS_SEGMANT_PACKED: PackedScene = preload("res://scenes/ui/battle/speedline/components/character_markers/character_markers_segment.tscn")


@onready var _speedline: HBoxContainer = $Speedline
@onready var _characters_markers: HBoxContainer = $Margin/CharactersMarkers


func set_atp_slots_by_speed(atp_slots_by_speed: Dictionary) -> void:
	var sorted_speeds: Array[int] = _get_sorted_speeds(atp_slots_by_speed)
	_speedline.set_speeds(sorted_speeds)
	_remove_characters_markers()
	_add_characters_markers(atp_slots_by_speed, sorted_speeds)


func _get_sorted_speeds(atp_slots_by_speed: Dictionary) -> Array[int]:
	var speeds: Array[int] = []
	speeds.assign(atp_slots_by_speed.keys())
	speeds.sort_custom(func(speed_1: int, speed_2: int) -> bool: return speed_1 > speed_2)
	return speeds


func _remove_characters_markers() -> void:
	for characters_markers_segmant: Node in _characters_markers.get_children():
		_characters_markers.remove_child(characters_markers_segmant)


func _add_characters_markers(atp_slots_by_speed: Dictionary, sorted_speeds: Array[int]) -> void:
	for speed: int in sorted_speeds:
		var atp_slots: Array[ATPSlot] = atp_slots_by_speed[speed]
		var characters_markers_segmant: HBoxContainer = _CHARACTERS_MARKERS_SEGMANT_PACKED.instantiate()
		_characters_markers.add_child(characters_markers_segmant)
		characters_markers_segmant.set_atp_slots(atp_slots)
