class_name Character
extends Node2D


signal fraction_changed(new_fraction: BattleEnums.Fraction)
signal died
signal stunned
signal came_out_of_stun

var stats: CharacterStats
var combat_model: CharacterCombatModel = CharacterCombatModel.new(self)
var view_model: CharacterViewModel = preload("res://scenes/battle/characters/base/abstract_character_view.tscn").instantiate()
var movement_model: CharacterMovementModel = preload("res://scenes/battle/characters/character_movement_model.tscn").instantiate()

var is_ally: bool :
	get: return fraction == BattleEnums.Fraction.ALLY
var is_dead: bool :
	get: return character_fsm.current_state is DeathState
var is_stunned: bool :
	get: return character_fsm.current_state is StunState
var is_active: bool:
	get: return not (is_stunned or is_dead)
var independently_arranges_skills : bool

var fraction: BattleEnums.Fraction :
	set(new_fraction):
		fraction = new_fraction
		fraction_changed.emit(new_fraction)
var atp_slots_manager: ATPSlotsManager
var character_fsm: CharacterFSM

var physical_health: BaseHealth :
	get: return health_manager.physical_health
var mental_health: BaseHealth :
	get: return health_manager.mental_health
var physical_resistance: BaseResistance :
	get: return health_manager.physical_resistance
var mental_resistance: BaseResistance :
	get: return health_manager.mental_resistance

@onready var skills_manager := SkillsManager.new(self, stats.skills)
@onready var health_manager := HealthManager.new(self)


func _init(battle_parameters: CharacterBattleParameters,
			character_fraction: BattleEnums.Fraction) -> void:
	y_sort_enabled = true
	stats = battle_parameters.stats
	fraction = character_fraction
	#_targets_setter = battle_parameters.auto_assault_setter


func _ready() -> void:
	movement_model.model = self
	view_model.model = self
	add_child(view_model)
	character_fsm = CharacterFSM.new(self)
	atp_slots_manager = ATPSlotsManager.new(self, view_model.atp_slots_manager_ui)
	_set_character_to_groups()


func _to_string() -> String:
	return stats.name


func get_movement_model() -> CharacterMovementModel: return movement_model

func get_slots_for_assaults() -> Array[ATPSlot]:
	return atp_slots_manager.get_atp_slots_for_assaults()

func get_slots_available_for_targeting() -> Array[ATPSlot]:
	return atp_slots_manager.get_atp_slots_available_for_targeting()


func to_die() -> void: health_manager.to_die()

func to_stun() -> void: health_manager.to_stun()


func make_independent() -> void:
	independently_arranges_skills = true

func remove_independent() -> void:
	independently_arranges_skills = false


func prepare_character() -> void:
	movement_model.set_to_default_position()
	view_model.flip_to_starting_position()
	atp_slots_manager.preparation_atp_slots()
	atp_slots_manager.atp_slots_managet_ui.show()
	if is_active:
		atp_slots_manager.roll_atp_slots()
		skills_manager.restore_skills()


func prepare_character_to_combat() -> void:
	atp_slots_manager.atp_slots_managet_ui.hide()


func auto_set_assault(opponents: Array[Character]) -> void:
	for atp_slot: ATPSlot in get_slots_for_assaults():
		var skill: Skill = skills_manager.auto_selects_skill_or_null()
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
