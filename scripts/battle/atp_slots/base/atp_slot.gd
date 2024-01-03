class_name ATPSlot
extends Resource


signal speed_changed(new_speed: int)
signal installed_skill_changed(new_skill: Skill)

enum ATPSlotState {
	NORMAL = 0,
	BROKEN = 1,
	BLOCKED = 2,
}

var speed: int = 0 :
	set(value):
		speed = value
		speed_changed.emit(value)
var assaulting_skill: Skill = null :
	set(new_skill):
		assaulting_skill = new_skill
		installed_skill_changed.emit(new_skill)

var wearer: Character

var _atp_slot_ui: BaseATPSlotUI
var _current_state: ATPSlotState = ATPSlotState.NORMAL


func _init(character: Character) -> void:
	wearer = character
	_atp_slot_ui = BaseATPSlotUI.create_atp_slot_ui(wearer.stats.type)
	_atp_slot_ui.set_model(self)


func _to_string() -> String:
	return "%s-ATP-%s" % [wearer.to_string(), speed]


func is_broken() -> bool:
	return _current_state == ATPSlotState.BROKEN

func is_blocked() -> bool:
	return _current_state == ATPSlotState.BLOCKED


func get_atp_slot_ui() -> BaseATPSlotUI: return _atp_slot_ui


func selected_skill(skill: Skill) -> void:
	deselected_skill()
	if skill != null:
		assaulting_skill = skill
		assaulting_skill.select()

func deselected_skill() -> void:
	if assaulting_skill != null:
		assaulting_skill.deselect()
		assaulting_skill = null


func remove_skill() -> void:
	assaulting_skill = null


func assault_can_be_executed() -> bool:
	return assaulting_skill != null and wearer.is_active
