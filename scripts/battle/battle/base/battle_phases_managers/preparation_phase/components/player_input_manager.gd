#class_name PlayerInputManager
extends Control


signal player_made_general_cancel

signal ally_picked(character: Character, atp_slot: ATPSlot)
signal ally_selected(character: Character, atp_slot: ATPSlot)
signal ally_deselected(character: Character, atp_slot: ATPSlot)

signal enemy_picked(character: Character, atp_slot: ATPSlot)
signal enemy_selected(character: Character, atp_slot: ATPSlot)
signal enemy_deselected(character: Character, atp_slot: ATPSlot)

signal skill_picked(skill: Skill)
signal skill_selected(skill: Skill)
signal skill_deselected(skill: Skill)


func _ready() -> void:
	ally_picked.connect(PlayerArrangeAssaults._on_ally_picked)
	enemy_picked.connect(PlayerArrangeAssaults._on_enemy_picked)
	ally_selected.connect(PlayerArrangeAssaults._on_character_selected)
	enemy_selected.connect(PlayerArrangeAssaults._on_character_selected)
	ally_deselected.connect(PlayerArrangeAssaults._on_character_deselected)
	enemy_deselected.connect(PlayerArrangeAssaults._on_character_deselected)
	player_made_general_cancel.connect(PlayerArrangeAssaults._on_player_made_general_cancel)


func get_character_picked_signal(character_is_ally: bool) -> Signal:
	return ally_picked if character_is_ally else enemy_picked

func get_character_selected_signal(character_is_ally: bool) -> Signal:
	return ally_selected if character_is_ally else enemy_selected

func get_character_deselected_signal(character_is_ally: bool) -> Signal:
	return ally_deselected if character_is_ally else enemy_deselected
