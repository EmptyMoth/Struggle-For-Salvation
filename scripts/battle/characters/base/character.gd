class_name Character
extends Node2D


signal fraction_changed(new_fraction: BattleEnums.Fraction)

signal won_clash(target: Character)
signal drew_clash(target: Character)
signal lost_clash(target: Character)

var stats: CharacterStats
var atp_slots_manager: ATPSlotsManager
var fraction: BattleEnums.Fraction

var is_ally: bool :
	get: return fraction == BattleEnums.Fraction.ALLY
var is_stunned: bool :
	get: return mental_health.is_empty()
var independently_arranges_skills : bool
var skills: Array[AbstractSkill] = []

var _skill_used: SkillCombatModel = null
var _dice_reserved_list: Array[AbstractActionDice] = []
var _auto_assault_setter: BaseAutoAssaultSetter

@onready var physical_health := PhysicalHealth.new(stats.max_physical_health)
@onready var mental_health := MentalHealth.new(stats.max_mental_health)
@onready var physical_resistance := BaseResistance.new(stats.physical_resistance)
@onready var mental_resistance := BaseResistance.new(stats.mental_resistance)

@onready var character_marker_3d: CharacterMarker3D = preload("res://scenes/battle/characters/character_marker_3d.tscn").instantiate()

@onready var _view: CharacterView = preload("res://scenes/battle/characters/base/abstract_character_view.tscn").instantiate()


func _init(battle_parameters: CharacterBattleParameters,
			character_fraction: BattleEnums.Fraction) -> void:
	y_sort_enabled = true
	stats = battle_parameters.stats
	_auto_assault_setter = battle_parameters.auto_assault_setter
	fraction = character_fraction


func _ready() -> void:
	_view.set_model(self)
	add_child(_view)
	atp_slots_manager = ATPSlotsManager.new(self, _view.atp_slots_manager_ui)

	_set_character_to_groups()
	for skill_stats in stats.skills:
		skills.append(AbstractSkill.create_skill(self, skill_stats))

	_connect_signals()


func _to_string() -> String:
	return stats.name


static func get_action_name(action: BattleParameters.CharactersMotions) -> String:
	var action_name: String = BattleParameters.CharactersMotions.find_key(action)
	return action_name.to_lower() if action_name != null else "default"


func get_view() -> CharacterView:
	return _view


func get_skill_used() -> SkillCombatModel:
	return _skill_used.use()


func make_independent() -> void:
	independently_arranges_skills = true

func remove_independent() -> void:
	independently_arranges_skills = false


func roll_atp_slots() -> void:
	atp_slots_manager.roll_atp_slots()


func to_die() -> void:
	take_physical_damage(physical_health.max_health)

func to_stun() -> void:
	take_mental_damage(mental_health.max_health)


func take_physical_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, physical_resistance, physical_health)

func take_mental_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, mental_resistance, mental_health)


func physical_heal(heal_amound: int) -> void:
	physical_health.heal(heal_amound)

func mental_heal(heal_amound: int) -> void:
	mental_health.heal(heal_amound)


func make_action(action: DiceAction) -> void:
	pass


func get_next_dice_reserved() -> AbstractActionDice:
	if _skill_used == null:
		var index: int = 0
		return _dice_reserved_list[index] if index < _dice_reserved_list.size() else null

	var dice_reserved: AbstractActionDice = _skill_used.get_next_dice_reserved()
	if dice_reserved != null:
		return dice_reserved
	return null


func auto_selecting_assault(opponents: Array[Node]) -> Dictionary:
	var opponents_by_atp_slot: Dictionary = {}
	for atp_slot in atp_slots_manager.get_all_atp_slots():
		var skill: AbstractSkill = _auto_take_skill()
		@warning_ignore("static_called_on_instance")
		var targets: Targets = skill.choose_targets_atp_slots(opponents) \
				if skill.is_auto_set_assault() \
				else _auto_assault_setter.choose_targets_atp_slot(opponents)
		atp_slot.set_skill(skill)
		opponents_by_atp_slot[atp_slot] = targets
	return opponents_by_atp_slot


func _set_character_to_groups() -> void:
	add_to_group("characters")
	add_to_group(BattleParameters.CHARACTERS_GROUPS_BY_FRACTIONS[fraction])
	add_to_group(BattleParameters.GROUPS_BY_CHARACTERS_TYPES[stats.type])
	if stats.type != BattleEnums.CharacterType.IMMUNOCYTE:
		add_to_group("pathogens")


func _take_damage(damage: int, is_permanent: bool,
			resistance: BaseResistance, health: AbstractHealth) -> int:
	var final_damage: int = damage if is_permanent else roundi(damage * resistance.get_value())
	health.take_damage(final_damage)
	return final_damage


func _connect_signals() -> void:
	physical_health.died.connect(_on_died)
	mental_health.stunned.connect(_on_stunned)
	mental_health.stunned.connect(physical_resistance._on_character_stunned)
	mental_health.stunned.connect(mental_resistance._on_character_stunned)


func _auto_take_skill() -> AbstractSkill:
	return skills.pick_random()


func _on_died() -> void:
	queue_free()


func _on_stunned() -> void:
	physical_resistance._on_character_stunned()
	mental_resistance._on_character_stunned()
