class_name AbstractCharacter
extends Node2D


signal picked(self_character: AbstractCharacter)
signal selected(self_character: AbstractCharacter)
signal deselected(self_character: AbstractCharacter)
signal unfolded_cards(cards: Array[AbstractCard])


@export var stats: CharacterStats = CharacterStats.new()
@export var deck_of_cards: DeckOfCards = DeckOfCards.new()
@export var icon: CompressedTexture2D = null

var is_themself_placement_cards: bool = false

@onready var is_ally: bool = "allies" in get_groups()

@onready var physical_health: PhysicalHealth = PhysicalHealth.new(stats.max_physical_health)
@onready var mental_health: MentalHealth = MentalHealth.new(stats.max_mental_health)
@onready var physical_resistance: PhysicalResistance = PhysicalResistance.new(stats.physical_resistance)
@onready var mental_resistance: MentalResistance = MentalResistance.new(stats.mental_resistance)
@onready var hand: Hand = Hand.new(deck_of_cards)

@onready var actions_animations: AnimatedSprite2D = $Actions
@onready var subcharacter_hud: SubcharacterHUD = $SubcharacterHUD
@onready var speed_dice_manager: SpeedDiceManager = $SpeedDiceManager

@onready var character_marker_3d: CharacterMarker3D = preload(
		"res://scenes/battle/characters/base_scenes/character_marker_3d.tscn").instantiate()


func _ready() -> void:
	subcharacter_hud.init(physical_health, mental_health)
	speed_dice_manager.init(stats.min_speed, stats.max_speed, stats.speed_dice_count)
	
	_connect_signals()


func _process(_delta: float) -> void:
	position = character_marker_3d.get_current_position_on_camera()


func prepare_for_card_placement() -> void:
	character_marker_3d.return_to_starting_position()
	flip_to_starting_position()
	roll_speed_dice()
	hand.update()


func prepare_for_combat() -> void:
	pass


func make_selected() -> void:
	z_index = 1


func cancel_selected() -> void:
	z_index = 0


func roll_speed_dice() -> void:
	speed_dice_manager.roll_speed_dice()


func die() -> void:
	take_physical_damage(physical_health.max_health)

func stun() -> void:
	take_mental_damage(mental_health.max_health)


func take_damage(damage: int) -> void:
	take_physical_damage(damage)
	take_mental_damage(damage)

func take_physical_damage(damage: int) -> void:
	_take_damage(damage, physical_resistance.get_value(), physical_health)

func take_mental_damage(damage: int) -> void:
	_take_damage(damage, mental_resistance.get_value(), mental_health)

func _take_damage(damage: int, resistance_value: float, health: AbstractHealth) -> void:
	damage = _calculate_damage(damage, resistance_value)
	health.take_damage(damage)

func _calculate_damage(damage: int, resistance_value: float) -> int:
	return roundi(damage * resistance_value)


func place_cards_themself() -> Array[AbstractSpeedDice]:
	var cards_by_speed_dice: Array[AbstractSpeedDice] = []
	for speed_dice in speed_dice_manager.get_all_speed_dice():
		var random_card: AbstractCard = hand.get_random_card()
		if random_card == null:
			break
		
		speed_dice.set_card(random_card)
		cards_by_speed_dice.append(speed_dice)
	
	return cards_by_speed_dice


func flip_to_starting_position() -> void:
	var window_width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
	var start_position: Vector2 = character_marker_3d.get_start_position_on_camera()
	actions_animations.flip_h = start_position.x < window_width / 2.0


func flip_to_specified_point(point_position: Vector2) -> void:
	actions_animations.flip_h = position < point_position


func flip_view_direction() -> void:
	actions_animations.flip_h = !actions_animations.flip_h


func actions_switcher(action: BattleParameters.Action) -> void:
	actions_animations.play(_get_action_name(action))

static func _get_action_name(action: BattleParameters.Action) -> String:
	var action_name: String = BattleParameters.Action.find_key(action)
	return action_name.to_lower() if action_name != null else "default"


func _connect_signals() -> void:
	@warning_ignore(return_value_discarded)
	physical_health.died.connect(_on_died)
	@warning_ignore(return_value_discarded)
	mental_health.stunned.connect(_on_stunned)
	
	for speed_dice in speed_dice_manager.get_all_speed_dice():
		@warning_ignore(return_value_discarded)
		speed_dice.selected.connect(_on_speed_dice_selected)
		@warning_ignore(return_value_discarded)
		speed_dice.deselected.connect(_on_speed_dice_deselected)


func _on_died() -> void:
	pass


func _on_stunned() -> void:
	pass


func _on_speed_dice_selected() -> void:
	make_selected()
	if is_ally:
		emit_signal("unfolded_cards", hand.cards)


func _on_speed_dice_deselected() -> void:
	cancel_selected()


func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("ui_pick"):
		emit_signal("picked", self)


func _on_click_area_mouse_entered() -> void:
	emit_signal("selected", self)


func _on_click_area_mouse_exited() -> void:
	emit_signal("deselected", self)
