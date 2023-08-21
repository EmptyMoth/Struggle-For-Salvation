class_name BaseCharacterPassiveAbility
extends AbstractAbility


@export_enum(
	"None", 
	"On Clash",
	"On One Side",
	"Clash Win", 
	"Clash Draw", 
	"Clash Lose",
	"On Roll Dice",
	"On Hit",
	"On Block",
	"On Evade",
	"After Area Attack", 
	) var _condition_title: String = "None"
