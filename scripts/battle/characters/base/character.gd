class_name Character
extends Node2D


signal fraction_changed(new_fraction: BattleEnums.Fraction)

var fraction: BattleEnums.Fraction
var atp_slots_manager: ATPSlotsManager
var skills_manager: SkillsManager

var is_ally: bool :
	get: return fraction == BattleEnums.Fraction.ALLY
var independently_arranges_skills : bool
var stats: CharacterStats

@onready var combat_model: CharacterCombatModel = CharacterCombatModel.new(self)
@onready var view_model: CharacterViewModel = preload("res://scenes/battle/characters/base/abstract_character_view.tscn").instantiate()
@onready var movement_model: CharacterMovementModel = preload("res://scenes/battle/characters/character_movement_model.tscn").instantiate()


func _init(battle_parameters: CharacterBattleParameters,
			character_fraction: BattleEnums.Fraction) -> void:
	y_sort_enabled = true
	stats = battle_parameters.stats
	fraction = character_fraction
	skills_manager = SkillsManager.new(self, stats.skills)
	#_targets_setter = battle_parameters.auto_assault_setter


func _ready() -> void:
	view_model.set_model(self)
	add_child(view_model)
	atp_slots_manager = ATPSlotsManager.new(self, view_model.atp_slots_manager_ui)
	_set_character_to_groups()
	_connect_signals()


func _to_string() -> String:
	return stats.name


static func get_action_name(action: BattleParameters.CharactersMotions) -> String:
	var action_name: String = BattleParameters.CharactersMotions.find_key(action)
	return action_name.to_lower() if action_name != null else "default"


func get_movement_model() -> CharacterMovementModel:
	return movement_model


func get_slots_for_assaults() -> Array[ATPSlot]:
	return atp_slots_manager.get_atp_slots_for_assaults()

func get_slots_available_for_targeting() -> Array[ATPSlot]:
	return atp_slots_manager.get_atp_slots_available_for_targeting()


func make_independent() -> void:
	independently_arranges_skills = true

func remove_independent() -> void:
	independently_arranges_skills = false


func auto_set_assault(opponents: Array[Node]) -> void:
	for atp_slot in get_slots_for_assaults():
		var skill: AbstractSkill = skills_manager.auto_selects_skill_or_null()
		if skill == null:
			return
		var targets_setter: BaseTargetsSetter = \
				skill.get_targets_setter() if skill.get_targets_setter() else stats.targets_setter
		var targets: Targets = AutoTargetsSetter.choose_targets(
				opponents, skill.targets_count, targets_setter)
		AssaultSetter.create_assault(atp_slot, targets, skill)


func _set_character_to_groups() -> void:
	add_to_group(BattleGroups.CHARACTERS_GROUP)
	add_to_group(BattleGroups.GROUPS_BY_FRACTIONS[fraction])
	add_to_group(BattleGroups.GROUPS_BY_CHARACTERS_TYPES[stats.type])
	if stats.type != BattleEnums.CharacterType.IMMUNOCYTE:
		add_to_group(BattleGroups.PATHOGENS_GROUP)


func _connect_signals() -> void:
	pass
#	physical_health.died.connect(_on_died)
#	mental_health.stunned.connect(_on_stunned)
#	mental_health.stunned.connect(physical_resistance._on_character_stunned)
#	mental_health.stunned.connect(mental_resistance._on_character_stunned)


func _on_died() -> void:
	print("%s is DEAD!" % self)


#func _on_stunned() -> void:
#	physical_resistance._on_character_stunned()
#	mental_resistance._on_character_stunned()


func _on_battle_turn_started() -> void:
	atp_slots_manager.roll_atp_slots()
	skills_manager.restore_skills()
	movement_model.move_to_default_position()
