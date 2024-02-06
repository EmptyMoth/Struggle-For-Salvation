class_name CharacterViewModel
extends Node


var model: Character

@onready var character_motions: AnimatedSprite2D = model.get_node("Actions")
@onready var subcharacter_bars: SubcharacterBars = model.get_node("SubcharacterBars")
@onready var atp_slots_manager_ui: ATPSlotsManagerUI = model.get_node("ATPSlotsContainer")
@onready var click_area: Button = model.get_node("Actions/ClickArea")
@onready var damage_label_position: Node2D = model.get_node("DamageLabelPosition")


func _init(character: Character) -> void:
	model = character


func _ready() -> void:
	click_area.modulate.a = 0
	model.died.connect(_on_character_died)
	model.taken_damage.connect(_on_character_taken_damage)
	click_area.pressed.connect(_on_character_pressed)
	click_area.mouse_exited.connect(_on_character_mouse_exited)
	click_area.mouse_entered.connect(_on_character_mouse_entered)
	damage_label_position.global_position = click_area.global_position + click_area.size / 2.0
	atp_slots_manager_ui.position.y = -click_area.size.y - 10
	subcharacter_bars.set_healths(
			model.health_manager.physical_health, model.health_manager.mental_health)
	switch_motion(BattleEnums.CharactersMotions.DEFAULT)


static func get_action_name(action: BattleEnums.CharactersMotions) -> String:
	var action_name: String = BattleEnums.CharactersMotions.find_key(action)
	return action_name.to_lower() if action_name != null else "default"


func get_position_for_popup_assault_info() -> Vector2:
	return model.position - Vector2(0, click_area.size.y + 30)


func make_selected() -> void:
	model.z_index = 1
	#click_area.modulate = Color("ffff00")

func cancel_selected() -> void:
	model.z_index = 0
	#click_area.modulate = Color.WHITE


func flip_to_starting_position() -> void:
	character_motions.flip_h = model.movement_model.default_position.x < 0

func flip_to_specified_point(point_position: Vector2) -> void:
	character_motions.flip_h = model.position < point_position

func flip_view_direction() -> void:
	character_motions.flip_h = !character_motions.flip_h


func switch_motion(action: BattleEnums.CharactersMotions) -> void:
	if get_action_name(action) == "death":
		character_motions.hide()
		return
	character_motions.play(get_action_name(action))


func prepare_character() -> void:
	flip_to_starting_position()
	atp_slots_manager_ui.show()

func prepare_character_to_combat() -> void:
	atp_slots_manager_ui.hide()


func _on_character_taken_damage(damage_info: DamageInfo) -> void:
	damage_label_position.add_child(DamageLabel.create_damage_label(damage_info))


func _on_character_died() -> void:
	atp_slots_manager_ui.hide()
	subcharacter_bars.hide()
	click_area.hide()


func _on_character_pressed() -> void:
	PlayerInputManager.get_character_picked_signal(model.is_ally).emit(model, null)

func _on_character_mouse_entered() -> void:
	PlayerInputManager.get_character_selected_signal(model.is_ally).emit(model, null)

func _on_character_mouse_exited() -> void:
	PlayerInputManager.get_character_deselected_signal(model.is_ally).emit(model, null)
