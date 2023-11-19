class_name CharacterView
extends Node2D


#signal picked(self_character: Character, self_atp_slot: ATPSlot)
#signal selected(self_character: Character, self_atp_slot: ATPSlot)
#signal deselected(self_character: Character, self_atp_slot: ATPSlot)

var _model: Character

@onready var character_motions: AnimatedSprite2D = $Actions
@onready var actions_animations: AnimationPlayer = $Actions/AnimationPlayer
@onready var subcharacter_bars: SubcharacterBars = $SubcharacterBars
@onready var atp_slots_manager_ui: ATPSlotsManagerUI = $ATPSlotsContainer


func _ready() -> void:
	subcharacter_bars.set_healths(_model.physical_health, _model.mental_health)
	switch_motion(BattleParameters.CharactersMotions.DEFAULT)
	_connect_signals()


func _process(_delta: float) -> void:
	position = _model.character_marker_3d.get_current_position_on_camera()


static func get_action_name(action: BattleParameters.CharactersMotions) -> String:
	var action_name: String = BattleParameters.CharactersMotions.find_key(action)
	return action_name.to_lower() if action_name != null else "default"


func set_model(model: Character) -> void:
	_model = model

func get_model() -> Character:
	return _model


func make_selected() -> void:
	z_index = 1
	$ClickArea.modulate = Color("ffff00")

func cancel_selected() -> void:
	z_index = 0
	$ClickArea.modulate = Color.WHITE


func make_action(action: DiceAction) -> void:
	pass


func flip_to_starting_position() -> void:
	var window_width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
	var default_position: Vector2 = _model.character_marker_3d.get_default_position_on_camera()
	character_motions.flip_h = default_position.x < window_width / 2.0

func flip_to_specified_point(point_position: Vector2) -> void:
	character_motions.flip_h = position < point_position

func flip_view_direction() -> void:
	character_motions.flip_h = !character_motions.flip_h


func switch_motion(action: BattleParameters.CharactersMotions) -> void:
	var animation_name: String = \
			"base_characters_actions/%s" % Character.get_action_name(action)
	actions_animations.play(animation_name)


func _connect_signals() -> void:
	BattleSignals.turn_started.connect(_on_turn_started)


func _on_turn_started() -> void:
	_model.character_marker_3d.move_to_default_position()
	flip_to_starting_position()


func _on_died() -> void:
	pass


func _on_stunned() -> void:
	pass


func _on_character_pressed() -> void:
	PlayerInputManager.get_character_picked_signal(_model.is_ally).emit(_model, null)

func _on_character_mouse_entered() -> void:
	PlayerInputManager.get_character_selected_signal(_model.is_ally).emit(_model, null)

func _on_character_mouse_exited() -> void:
	PlayerInputManager.get_character_deselected_signal(_model.is_ally).emit(_model, null)
