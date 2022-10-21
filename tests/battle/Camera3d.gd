extends Camera3D


var _in_battle: bool = false


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if _in_battle:
			end_battle()
		else:
			start_battle()
		#end_battle() if _in_battle else start_battle()
		_in_battle = !_in_battle


func start_battle() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "rotation:x", -PI/18, 1)
	tween.parallel().tween_property(self, "position:y", 2.5, 1)

func end_battle() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "rotation:x", -PI/6, 1)
	tween.parallel().tween_property(self, "position:y", 6.0, 1)
