class_name BattlefieldCamera
extends Camera3D


func move_to_combat_position() -> void:
	var tween: Tween = get_tree().create_tween().set_parallel()
	@warning_ignore("return_value_discarded")
	tween.tween_property(self, "rotation:x", -PI/18, 1)
	@warning_ignore("return_value_discarded")
	tween.tween_property(self, "position:y", 2.5, 1)

func move_to_normal_position() -> void:
	var tween: Tween = get_tree().create_tween().set_parallel()
	@warning_ignore("return_value_discarded")
	tween.tween_property(self, "rotation:x", -PI/6, 1)
	@warning_ignore("return_value_discarded")
	tween.tween_property(self, "position:y", 6.0, 1)
