class_name BaseATPSlotUI
extends Button


enum ATPSlotState { 
	NORMAL = 0,
	BROKEN = 1,
	BLOCKED = 2,
}

const _ATP_SLOT_UI_BY_CHARACTER_TYPE: Dictionary = {
	BattleEnums.CharacterType.IMMUNOCYTE : preload("res://scenes/ui/battle/atp_slots/base/abstract_atp_slot.tscn")
}

var center_position: Vector2 :
	get: return global_position + scale * size / 2

var current_state: ATPSlotState = ATPSlotState.NORMAL

var _model: ATPSlot
var _is_fixed: bool = false

@onready var _speed_value_label: Label = $SpeedValue


func _ready() -> void:
	pressed.connect(_on_ally_atp_pressed if _model.wearer.is_ally else _on_enemy_atp_pressed)


func _draw() -> void:
	match get_draw_mode():
		DRAW_NORMAL:
			_make_normal()
		DRAW_HOVER:
			_make_hover()
		DRAW_PRESSED, DRAW_HOVER_PRESSED:
			_make_pressed()
		DRAW_DISABLED:
			if current_state == ATPSlotState.BROKEN:
				_make_broken()
			else:
				_make_blocked()


static func create_atp_slot_ui(character_type: BattleEnums.CharacterType) -> BaseATPSlotUI:
	return _ATP_SLOT_UI_BY_CHARACTER_TYPE.get(character_type, \
			preload("res://scenes/ui/battle/atp_slots/base/abstract_atp_slot.tscn"))\
			.instantiate()


func set_model(atp_slot: ATPSlot) -> void:
	_model = atp_slot
	_model.speed_changed.connect(_on_speed_changed)
	_model.installed_skill_changed.connect(_on_installed_skill_changed)


func deselected() -> void:
	set_pressed_no_signal(false)


func _make_normal() -> void:
	modulate = Color.WHITE
	if not _is_fixed and scale != Vector2.ONE:
		_animate_scale(Vector2.ONE)


func _make_hover() -> void:
	if scale != 1.2 * Vector2.ONE:
		_animate_scale(1.2 * Vector2.ONE)


func _make_pressed() -> void:
	modulate = Color.ROYAL_BLUE


func _make_broken() -> void:
	pass


func _make_blocked() -> void:
	pass


func _animate_scale(new_scale: Vector2 = Vector2.ONE) -> void:
	get_tree().create_tween()\
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)\
			.tween_property(self, "scale", new_scale, 0.2)


func _on_speed_changed(new_speed: int) -> void:
	_speed_value_label.text = str(new_speed)


func _on_installed_skill_changed(new_skill: AbstractSkill) -> void:
	if new_skill == null:
		pass
		return
	
	var skill_icon: Texture2D = new_skill.stats.icon
	pass


func _on_atp_pressed() -> void:
	if Input.is_action_just_released("ui_pick"):
		_model.wearer.get_view().picked.emit(_model.wearer, _model)

func _on_ally_atp_pressed() -> void:
	_on_atp_pressed()
	if Input.is_action_just_released("ui_pick"):
		@warning_ignore("static_called_on_instance")
		PlayerInputManager.on_ally_atp_slot_selected(_model)
	elif Input.is_action_just_released("ui_cancel"):
		@warning_ignore("static_called_on_instance")
		PlayerInputManager.on_ally_atp_slot_deselected(_model)

func _on_enemy_atp_pressed() -> void:
	_on_atp_pressed()
	if Input.is_action_just_released("ui_pick"):
		@warning_ignore("static_called_on_instance")
		PlayerInputManager.on_enemy_atp_slot_selected(_model)


func _on_atp_mouse_entered() -> void:
	_model.wearer.get_view().selected.emit(_model.wearer, _model)
	AssaultsArrowsManager.show_arrows_by_atp_slot(_model)

func _on_atp_mouse_exited() -> void:
	_model.wearer.get_view().deselected.emit(_model.wearer, _model)
	AssaultsArrowsManager.hide_arrows_by_atp_slot(_model)
