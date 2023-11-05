class_name ActionAnimation
extends Animation


func set_participants(
			character: Character, 
			target: Character) -> void:
	for i in get_track_count():
		var pattern_track: String = str(track_get_path(i))
		pattern_track = pattern_track.replace("Character", character.name)
		pattern_track = pattern_track.replace("Target", target.name)
		track_set_path(i, pattern_track)


func set_mass_participants(
			character: Character, 
			targets: Array[Character]) -> void:
	for i in get_track_count():
		var pattern_track: String = str(track_get_path(i))
		pattern_track = pattern_track.replace("Character", character.name)
		for j in targets:
			pattern_track = pattern_track.replace("Target%s" % j, targets[j].name)
		track_set_path(i, pattern_track)
