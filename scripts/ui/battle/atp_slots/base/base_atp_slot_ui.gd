class_name BaseATPSlotUI
extends Button


const _ATP_SLOT_UI_BY_CHARACTER_TYPE: Dictionary = {
	BattleEnums.CharacterType.IMMUNOCYTE : preload("res://scenes/ui/battle/atp_slots/base/abstract_atp_slot.tscn")
}

var center_position: Vector2 :
	get: return global_position + scale * size / 2
var is_selected: bool :
	get:
		var draw_mode: DrawMode = get_draw_mode()
		return draw_mode != DRAW_NORMAL and draw_mode != DRAW_DISABLED

var _model: ATPSlot
var _is_fixed: bool = false

@onready var _speed_value_label: Label = $SpeedValue
@onready var _body: TextureRect = $Body
@onready var _icon: TextureRect = $Icon
@onready var _skill_icon: TextureRect = $SkillIcon


func _draw() -> void:
	match get_draw_mode():
		DRAW_NORMAL:
			_make_normal()
		DRAW_HOVER:
			_make_hover()
		DRAW_PRESSED, DRAW_HOVER_PRESSED:
			_make_pressed()
		DRAW_DISABLED:
			if _model.is_broken():
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
	if not is_selected:#not _is_fixed and scale != Vector2.ONE:
		_animate_scale(Vector2.ONE)


func _make_hover() -> void:
	if is_selected:#scale != 1.2 * Vector2.ONE:
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
		_body.modulate = Color.WHITE
		_icon.show()
		_skill_icon.hide()
		return
	
	_icon.hide()
	_skill_icon.show()
	_skill_icon.texture = new_skill.stats.icon
	_body.modulate = Color.MIDNIGHT_BLUE


func _on_atp_pressed() -> void:
	PlayerInputManager.get_character_picked_signal(_model.wearer.is_ally).emit(_model.wearer, _model)

func _on_atp_mouse_entered() -> void:
	PlayerInputManager.get_character_selected_signal(_model.wearer.is_ally).emit(_model.wearer, _model)

func _on_atp_mouse_exited() -> void:
	PlayerInputManager.get_character_deselected_signal(_model.wearer.is_ally).emit(_model.wearer, _model)
