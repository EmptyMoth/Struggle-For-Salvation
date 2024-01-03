class_name BaseActionDiceAbility
extends AbstractAbility


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
