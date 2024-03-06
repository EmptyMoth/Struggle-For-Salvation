extends Node2D


@export var _packed_formation: PackedScene

var animation_is_happening_now: bool = false

@onready var main_character: Character = _get_character($Characters/Allies)
@onready var main_target: Character = _get_character($Characters/Enemies)
@onready var allies: Array[Character] = _get_characters($Characters/Allies)
@onready var enemies: Array[Character] = _get_characters($Characters/Enemies)


func _ready() -> void:
	allies.pop_front()
	enemies.pop_front()
	_set_battlefild($TestLocation.battlefield)
	_prepare_characters()
	for character: Character in _get_characters($Characters/Allies) + _get_characters($Characters/Enemies):
		character.view_model.atp_slots_manager_ui.hide()
		character.view_model.subcharacter_bars.hide()
	for action_button: BaseButton in $BackgroundControl/Control.get_children():
		action_button.action_pressed.connect(_on_action_button_pressed)


func _get_character(node: Node) -> Character:
	return node.get_child(0) as Character


func _get_characters(node: Node) -> Array[Character]:
	var result: Array[Character] = []
	result.assign(node.get_children())
	return result


func _set_battlefild(battlefield: BaseBattlefield) -> void:
	var ally_team: Array[Character] = _get_characters($Characters/Allies)
	var enemy_team: Array[Character] = _get_characters($Characters/Enemies)
	battlefield.set_characters_markers_on_battlefield(ally_team, enemy_team)
	battlefield.set_formation(_packed_formation.instantiate(), ally_team, enemy_team)


func _prepare_characters() -> void:
	main_character.movement_model.set_to_default_position()
	main_target.movement_model.set_to_default_position()
	for character: Character in allies:
		character.movement_model.set_to_default_position()
	for character: Character in enemies:
		character.movement_model.set_to_default_position()


func _on_action_button_pressed(actions: Array[Action], is_mass_attack: bool) -> void:
	if animation_is_happening_now:
		return
	animation_is_happening_now = true
	main_character.movement_model.move_to_one_side(main_target)
	await main_character.movement_model.came_to_position
	var opponents: Opponents = Opponents.fast_init(main_target, enemies if is_mass_attack else ([] as Array[Character]))
	ActionsManager
	for action: Action in actions:
		action.execute(main_character, opponents.main, opponents.sub_targets)
		await action.finished
	_prepare_characters()
	animation_is_happening_now = false
