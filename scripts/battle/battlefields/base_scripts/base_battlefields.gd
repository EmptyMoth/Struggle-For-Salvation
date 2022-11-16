class_name BaseBattlefield
extends Node3D


func set_formation(formation: Formation) -> void:
	add_child(formation)
