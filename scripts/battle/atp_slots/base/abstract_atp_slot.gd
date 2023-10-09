class_name ATPSlot
extends Resource


signal speed_changed(new_speed: int)
signal installed_skill_changed(new_skill: AbstractSkill)

var speed: int = 0 :
	set(value):
		speed = value
		speed_changed.emit(value)
var installed_skill: AbstractSkill = null :
	set(new_skill):
		installed_skill = new_skill

var wearer: Character

var _atp_slot_ui: BaseATPSlotUI


func _init(character: Character) -> void:
	wearer = character
	_atp_slot_ui = BaseATPSlotUI.create_atp_slot_ui(wearer.stats.type)
	_atp_slot_ui.set_model(self)


func _to_string() -> String:
	return "%s-ATP-%s" % [wearer.to_string(), speed]


func get_atp_slot_ui() -> BaseATPSlotUI:
	return _atp_slot_ui


func set_skill(skill: AbstractSkill) -> void:
	remove_skill()
	installed_skill = skill
	installed_skill.select()

func remove_skill() -> void:
	if installed_skill != null:
		installed_skill.deselect()
	installed_skill = null
