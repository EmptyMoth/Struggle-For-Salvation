extends HBoxContainer


func set_side(side: Side) -> void:
	var arrow: TextureRect = $Arrow
	match side:
		SIDE_LEFT:
			arrow.flip_h = true
			move_child(arrow, 0)
		SIDE_TOP:
			arrow.flip_v = true
			move_child(arrow, 0)
