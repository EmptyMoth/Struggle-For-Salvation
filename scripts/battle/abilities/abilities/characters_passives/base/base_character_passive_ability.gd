class_name BaseCharacterPassiveAbility
extends AbstractAbility


@export var passive_title: String = ""
@warning_ignore("unused_private_class_variable")
@export_enum(
	"None", 
	"On Clash",
	"On One Side",
	"Clash Win", 
	"Clash Draw", 
	"Clash Lose",
	"On Roll Dice",
	"On Hit",
	"On BlockMotion",
	"On EvadeMotion",
	"After Area Attack", 
	) var _condition_title: String = "None"


func _get_description() -> String:
	@warning_ignore("static_called_on_instance")
	return " - ".join([passive_title, _effect.get_description()])
