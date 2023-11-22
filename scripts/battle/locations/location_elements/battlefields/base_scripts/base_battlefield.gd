class_name BaseBattlefield
extends Node3D


func set_characters_markers_on_battlefield(allies: Array[Node], enemies: Array[Node]) -> void:
	var node_with_characters: Node3D = $Characters
	for character in allies + enemies:
		node_with_characters.add_child(character.movement_model)


func set_formation(formation: BaseFormation, allies: Array, enemies: Array) -> void:
	add_child(formation)
	_set_characters_default_positions(
			formation, allies, formation.get_ally_position_by_index)
	_set_characters_default_positions(
			formation, enemies, formation.get_enemy_position_by_index)


func _set_characters_default_positions(formation: BaseFormation,
		characters: Array, character_position_func: Callable) -> void:
	for character in characters:
		var character_index: int = character.get_index()
		var default_position: Vector3 = character_position_func.call(character_index)
		character.movement_model.set_default_position(default_position)
