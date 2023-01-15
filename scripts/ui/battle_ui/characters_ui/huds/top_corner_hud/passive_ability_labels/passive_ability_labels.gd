class_name PassiveAbilityLabels
extends MarginContainer


@onready var _container_passive_abilities: VBoxContainer = $MarginContainer/ScrollContainer/ContainerPassiveAbilities
@onready var _passive_ability_label: Label = $MarginContainer/ScrollContainer/ContainerPassiveAbilities/PassiveAbility

var passive_abilities_count: int = 0


func add_passive_abilities(passive_abilities: Array[PassiveAbility]) -> void:
	if passive_abilities == null or passive_abilities.size() == 0:
		return
	
	for passive_ability in passive_abilities:
		add_passive_ability(passive_ability)

func add_passive_ability(passive_ability: PassiveAbility) -> void:
	if passive_ability == null:
		return
	
	var duplicate_label : Label = _passive_ability_label.duplicate()
	duplicate_label.text = passive_ability.to_string()
	_container_passive_abilities.add_child(duplicate_label)
	passive_abilities_count += 1


func remove_passive_abilities(passive_abilities: Array[PassiveAbility]) -> void:
	if passive_abilities == null or passive_abilities.size() == 0:
		return
	
	for passive_ability in passive_abilities: 
		remove_passive_ability(passive_ability)

func remove_passive_ability(passive_ability: PassiveAbility) -> void:
	if passive_ability == null:
		return
	
	var label_to_remove: Label = _find_passive_ability(passive_ability)
	if label_to_remove != null:
		_container_passive_abilities.remove_child(label_to_remove)
		passive_abilities_count -= 1


func clear_passive_abilities() -> void:
	passive_abilities_count = 0
	for passive_ability in _container_passive_abilities.get_children():
		_container_passive_abilities.remove_child(passive_ability)


func _find_passive_ability(passive_ability: PassiveAbility) -> Label:
	var passive_abilities_labels: Array[Label] = _container_passive_abilities.get_children()
	var desired_passive_abilities: Array[Label] = passive_abilities_labels.filter(
		func (pasiive_ability_label: Label): 
			return pasiive_ability_label.text.begins_with(passive_ability.name)
	)
	
	return desired_passive_abilities.front()
