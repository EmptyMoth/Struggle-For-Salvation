class_name ATPSlotsManagerUI
extends HBoxContainer


func add_atp_slot(atp_slot: BaseATPSlotUI) -> void:
	add_child(atp_slot)


func remove_atp_slot(atp_slot: BaseATPSlotUI) -> void:
	remove_child(atp_slot)
