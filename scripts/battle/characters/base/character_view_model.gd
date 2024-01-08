class_name CharacterViewModel
extends Node


var model: Character

@onready var character_motions: AnimatedSprite2D = model.get_node("Actions")
@onready var subcharacter_bars: SubcharacterBars = model.get_node("SubcharacterBars")
@onready var atp_slots_manager_ui: ATPSlotsManagerUI = model.get_node("ATPSlotsContainer")
@onready var click_area: Button = model.get_node("Actions/ClickArea")


func _init(character: Character) -> void:
	model = character


func _ready() -> void:
	click_area.pressed.connect(_on_character_pressed)
	click_area.mouse_exited.connect(_on_character_mouse_exited)
	click_area.mouse_entered.connect(_on_character_mouse_entered)
	atp_slots_manager_ui.position.y = -click_area.size.y - 10
	subcharacter_bars.set_healths(
			model.health_manager.physical_health, model.health_manager.mental_health)
	switch_motion(BattleEnums.CharactersMotions.DEFAULT)


static func get_action_name(action: BattleEnums.CharactersMotions) -> String:
	var action_name: String = BattleEnums.CharactersMotions.find_key(action)
	return action_name.to_lower() if action_name != null else "default"


func set_position() -> void:
	model.position = model.movement_model.get_current_position_on_camera()


func get_position_for_popup_assault_info() -> Vector2:
	return model.position - Vector2(0, click_area.size.y + 30)


func make_selected() -> void:
	model.z_index = 1
	click_area.modulate = Color("ffff00")

func cancel_selected() -> void:
	model.z_index = 0
	click_area.modulate = Color.WHITE


func flip_to_starting_position() -> void:
	character_motions.flip_h = model.movement_model.default_position.x < 0

func flip_to_specified_point(point_position: Vector2) -> void:
	character_motions.flip_h = model.position < point_position

func flip_view_direction() -> void:
	character_motions.flip_h = !character_motions.flip_h


func switch_motion(action: BattleEnums.CharactersMotions) -> void:
	character_motions.play(get_action_name(action))


func _on_character_pressed() -> void:
	PlayerInputManager.get_character_picked_signal(model.is_ally).emit(model, null)

func _on_character_mouse_entered() -> void:
	PlayerInputManager.get_character_selected_signal(model.is_ally).emit(model, null)

func _on_character_mouse_exited() -> void:
	PlayerInputManager.get_character_deselected_signal(model.is_ally).emit(model, null)
