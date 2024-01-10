class_name CharacterFSM
extends Resource


var model: Character

var current_state: AbstractCharacterState : 
	set(new_state):
		if str(current_state) == str(new_state):
			return
		current_state = new_state
		if not new_state is ActionState:
			model.view_model.switch_motion(new_state.get_motions())


func _init(character: Character) -> void:
	model = character
	character.physical_health.reached_zero.connect(_on_physical_health_reached_zero)
	character.mental_health.reached_zero.connect(_on_mental_health_reached_zero)
	character.came_out_of_stun.connect(_on_character_came_out_of_stun)
	character.movement_model.began_to_move.connect(_on_character_began_to_move)
	character.started_performing_action.connect(_on_character_started_performing_action)
	character.finished_performing_action.connect(_on_character_finished_performing_action)
	current_state = DefaultState.new(model)


func _on_physical_health_reached_zero() -> void:
	current_state = DeathState.new(model)

func _on_mental_health_reached_zero() -> void:
	if model.is_active:
		current_state = StunState.new(model)


func _on_character_came_out_of_stun() -> void:
	current_state = DefaultState.new(model)


func _on_character_began_to_move() -> void:
	if model.is_active:
		current_state = MovementState.new(model)

#func _on_character_finished_to_move() -> void:
	#if model.is_active:
		#current_state = DefaultState.new(model)


func _on_character_started_performing_action() -> void:
	if model.is_active:
		current_state = ActionState.new(model)

func _on_character_finished_performing_action() -> void:
	if model.is_active:
		current_state = DefaultState.new(model)

