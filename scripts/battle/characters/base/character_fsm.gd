class_name CharacterFSM
extends Resource


var model: Character

var current_state: AbstractCharacterState : 
	set(new_state):
		current_state = new_state
		model.view_model.switch_motion(new_state.get_motions())
var is_active: bool :
	get: return not (current_state is StunState or current_state is DeathState)


func _init(character: Character) -> void:
	model = character
	character.physical_health.reached_zero.connect(_on_physical_health_reached_zero)
	character.mental_health.reached_zero.connect(_on_mental_health_reached_zero)
	current_state = DefaultState.new(model)


func _on_physical_health_reached_zero() -> void:
	current_state = DeathState.new(model)

func _on_mental_health_reached_zero() -> void:
	current_state = StunState.new(model)
