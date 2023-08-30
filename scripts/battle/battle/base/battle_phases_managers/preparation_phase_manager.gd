class_name PreparationPhaseManager
extends Resource



static var _assaults_by_speed_dice: Dictionary = {}
static var _assaults_by_target_speed_dice: Dictionary = {}
static var _assaults_can_clash_by_target_speed_dice: Dictionary = {}
static var _default_assaults_by_speed_dice: Dictionary = {}


static func auto_arranges_enemies_assaults() -> void:
	var enemies: Array[Node] = GlobalParameters.get_nodes_in_group("enemies")
	var allies: Array[Node] = GlobalParameters.get_nodes_in_group("allies")
	_auto_arranges_characters_assaults(enemies, allies)
	_default_assaults_by_speed_dice = _assaults_by_speed_dice.duplicate()

static func auto_arranges_allies_assaults() -> void:
	var allies: Array[Node] = GlobalParameters.get_nodes_in_group("allies")
	var enemies: Array[Node] = GlobalParameters.get_nodes_in_group("enemies")
	_auto_arranges_characters_assaults(allies, enemies)


static func set_assault(
			character_speed_dice: AbstractSpeedDice, 
			target_speed_dice: AbstractSpeedDice) -> void:
	var target_assault: Assault = _assaults_by_speed_dice.get(target_speed_dice,
			Assault.new(target_speed_dice, null, BattleParameters.AssaultType.ONE_SIDE))
	if character_speed_dice.speed > target_speed_dice.speed \
			or target_assault.target_speed_dice == character_speed_dice:
		_replace_assaults(Assault.new(
			character_speed_dice, target_speed_dice, BattleParameters.AssaultType.CLASH))
		_replace_assaults(Assault.new(
			target_speed_dice, character_speed_dice, BattleParameters.AssaultType.CLASH))
	else:
		_replace_assaults(Assault.new(
			character_speed_dice, target_speed_dice, BattleParameters.AssaultType.ONE_SIDE))


static func there_are_alternative_clash(character_speed_dice: AbstractSpeedDice) -> bool:
	return 1 < _assaults_can_clash_by_target_speed_dice.get(character_speed_dice, []).size()


static func change_opponent_in_clash(target_speed_dice: AbstractSpeedDice) -> void:
	var assaults: Array[Assault] = _assaults_can_clash_by_target_speed_dice.get(
			target_speed_dice, [])
	for i in assaults.size():
		var assault: Assault = assaults[i]
		if assault.type != BattleParameters.AssaultType.CLASH:
			continue
		assault.change_assault_type(BattleParameters.AssaultType.ONE_SIDE)
		var next_index: int = (i + 1) % assaults.size()
		var new_clash_assault: Assault = assaults[next_index]
		new_clash_assault.change_assault_type(BattleParameters.AssaultType.CLASH)
		_replace_assaults(Assault.new(
			target_speed_dice,
			new_clash_assault.character_speed_dice,
			BattleParameters.AssaultType.CLASH))
		return


static func get_assaults_by_speed() -> Dictionary:
	var assaults_by_speed: Dictionary = {}
	for speed_dice in _assaults_by_speed_dice:
		var assault: Assault = _assaults_by_speed_dice[speed_dice]
		var assaults: Array[Assault] = assaults_by_speed.get(speed_dice.speed, [])
		assaults.append(assault)
		assaults_by_speed[speed_dice.speed] = assaults
	
	return assaults_by_speed


static func _auto_arranges_characters_assaults(
			characters: Array, 
			opponents: Array) -> void:
	for character in characters:
		var opponents_speed_dice_by_character_speed_dice: Dictionary = \
				character.auto_selecting_assault(opponents)
		for character_speed_dice in opponents_speed_dice_by_character_speed_dice:
			var opponent_speed_dice: AbstractSpeedDice = \
					opponents_speed_dice_by_character_speed_dice[character_speed_dice]
			set_assault(character_speed_dice, opponent_speed_dice)


static func _replace_assaults(new_assault: Assault) -> void:
	var old_assault: Assault = _assaults_by_speed_dice.get(new_assault.character_speed_dice)
	if old_assault != null:
		_remove_assault(old_assault)
	_add_assault(new_assault)


static func _add_assault(assault: Assault) -> void:
	_assaults_by_speed_dice[assault.character_speed_dice] = assault
	if assault.type == BattleParameters.AssaultType.CLASH:
		var assaults: Array[Assault] = _assaults_can_clash_by_target_speed_dice.get(assault.target_speed_dice, [])
		assaults.append(assault)
		_assaults_by_target_speed_dice[assault.target_speed_dice] = assaults
	var assaults: Array[Assault] = _assaults_by_target_speed_dice.get(assault.target_speed_dice, [])
	assaults.append(assault)
	_assaults_by_target_speed_dice[assault.target_speed_dice] = assaults


static func _remove_assault(assault: Assault) -> void:
	_assaults_by_speed_dice.erase(assault.character_speed_dice)
	if assault.type == BattleParameters.AssaultType.CLASH:
		var assaults: Array[Assault] = _assaults_can_clash_by_target_speed_dice.get(assault.target_speed_dice, [])
		assaults.erase(assault)
	var assaults: Array[Assault] = _assaults_by_target_speed_dice.get(assault.target_speed_dice, [])
	assaults.erase(assault)


static func _set_default_assault(character_speed_dice: AbstractSpeedDice) -> void:
	var default_assault: Assault = _default_assaults_by_speed_dice.get(character_speed_dice)
	if default_assault == null:
		_assaults_by_speed_dice.erase(character_speed_dice)
		return
	_add_assault(default_assault)
