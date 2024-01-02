class_name CharacterAssaultInfo
extends Resource


var character: Character
var attacker_atp_slot: ATPSlot
var opponents: Opponents
var targets: Targets

var current_skill: Skill
var current_action_dice: ActionDice


func _init(assault_data: AssaultData) -> void:
	attacker_atp_slot = assault_data.atp_slot
	targets = assault_data.targets
	character = attacker_atp_slot.wearer
	opponents = Opponents.new(targets)
