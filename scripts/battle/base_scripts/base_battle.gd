class_name BaseBattle
extends Node2D


enum BattlePhase { CARD_PLACEMENT, COMBAT }

@export var _packed_formation: PackedScene

var characters: Array[AbstractCharacter] :
	get: return left_characters + right_characters
var left_characters: Array[Node] :
	get: return $Characters/Left.get_children()
var right_characters: Array[Node] :
	get: return $Characters/Right.get_children()
var ally_team: Array[Node] :
	get: return get_tree().get_nodes_in_group("allies")
var enemy_team: Array[Node] :
	get: return get_tree().get_nodes_in_group("enemies")

var turns_count: int = 0
var current_phase: BattlePhase = BattlePhase.COMBAT

@onready var _battlefield: BaseBattlefield = $SubViewport/Battle3D
@onready var _card_manager: CardManager = $CharactersHUDs/CardManager
@onready var _left_top_corner_hud: BaseTopCornerHUD = $CharactersHUDs/LeftTopCornerHUD
@onready var _right_top_corner_hud: BaseTopCornerHUD = $CharactersHUDs/RightTopCornerHUD
@onready var _formation: Formation = _packed_formation.instantiate()


func _ready() -> void:
	_battlefield.set_formation(_formation)
	
	for ally in ally_team:
		ally.unfolded_cards.connect(_on_ally_unfolded_cards)
		_set_ally_start_position_on_battlefield(ally)
	for enemy in enemy_team:
		_set_enemy_start_position_on_battlefield(enemy)
	
	for character in characters:
		@warning_ignore(return_value_discarded)
		character.picked.connect(_on_character_picked)
		@warning_ignore(return_value_discarded)
		character.selected.connect(_on_character_selected)
		@warning_ignore(return_value_discarded)
		character.deselected.connect(_on_character_deselected)
		
	
	_switch_battle_phase()


func _input(_event: InputEvent) -> void:
	if current_phase == BattlePhase.CARD_PLACEMENT \
			and Input.is_action_just_released("ui_switch_battle_phase"):
		_switch_battle_phase()
	
	if Input.is_action_just_released("ui_menu"):
		$CanvasLayer/PauseMenu.pause_game()


func victory() -> void:
	end()

func defeate() -> void:
	end()

func end() -> void:
	pass


func set_cards_in_card_manager(cards: Array[AbstractCard]) -> void:
	_card_manager.put_cards(cards)


func _switch_battle_phase() -> void:
	match current_phase:
		BattlePhase.COMBAT:
			turns_count += 1
			_implements_card_placement_phase()
		BattlePhase.CARD_PLACEMENT:
			_implements_combat_phase()
			_switch_battle_phase()


func _implements_card_placement_phase() -> void:
	current_phase = BattlePhase.CARD_PLACEMENT
	get_tree().call_group("characters", "prepare_for_card_placement")
	CardPlacementManager.characters_place_cards_themselves(characters)


func _implements_combat_phase() -> void:
	current_phase = BattlePhase.COMBAT
	get_tree().call_group("characters", "prepare_for_combat")


func _set_ally_start_position_on_battlefield(ally: AbstractCharacter) -> void:
	var ally_marker: CharacterMarker3D = ally.character_marker_3d
	var allies: Node3D = _battlefield.get_node("Characters/Allies")
	_formation.set_ally_start_position(ally_marker, ally.get_index())
	allies.add_child(ally_marker)


func _set_enemy_start_position_on_battlefield(enemy: AbstractCharacter) -> void:
	var enemy_marker: CharacterMarker3D = enemy.character_marker_3d
	var enemies: Node3D = _battlefield.get_node("Characters/Enemies")
	_formation.set_enemy_start_position(enemy_marker, enemy.get_index())
	enemies.add_child(enemy_marker)


func _on_ally_unfolded_cards(cards: Array[AbstractCard]) -> void:
	set_cards_in_card_manager(cards)


func _on_character_picked(character: AbstractCharacter) -> void:
	if character in left_characters:
		_left_top_corner_hud.toggle_pinned()
	else:
		_right_top_corner_hud.toggle_pinned()


func _on_character_selected(character: AbstractCharacter) -> void:
	if character in left_characters:
		print(left_characters)
		_left_top_corner_hud.set_character(character)
	else:
		_right_top_corner_hud.set_character(character)


func _on_character_deselected(character: AbstractCharacter) -> void:
	if character in left_characters:
		_left_top_corner_hud.close()
	else:
		_right_top_corner_hud.close()
