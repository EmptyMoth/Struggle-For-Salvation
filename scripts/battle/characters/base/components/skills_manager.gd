class_name SkillsManager
extends RefCounted


var wearer: Character
var skills_count: int :
	get: return _skills.size()

var _skills: Array[Skill] = []


func _init(character: Character, skills_stats: Array[SkillStats]) -> void:
	wearer = character
	for skill_stats: SkillStats in skills_stats:
		_skills.append(Skill.new(character, skill_stats))
	_skills.sort_custom(func(skill1: Skill, skill2: Skill) -> bool: 
			return skill1.stats.priority >= skill2.stats.priority)


func get_all_skills() -> Array[Skill]:
	return _skills.duplicate()


func get_available_skills() -> Array[Skill]:
	return _skills.filter(func(skill: Skill) -> bool: return skill.is_available)


func restore_skills() -> void:
	for skill: Skill in _skills:
		skill.restore()


func auto_selects_skill_or_null() -> Skill:
	var skills: Array[Skill] = _get_highest_priority_available_skills()
	return skills.pick_random() if skills.size() > 0 else null


func _get_highest_priority_available_skills() -> Array[Skill]:
	var skills: Array[Skill] = []
	var available_skills: Array[Skill] = get_available_skills()
	for skill: Skill in available_skills:
		if skill.stats.priority != available_skills[0].stats.priority:
			break
		skills.append(skill)
	return skills
