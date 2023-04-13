class_name CardManager
extends Control


var cards: Array[Node] :
	get: return cards_container.get_children()

@onready var cards_container: HBoxContainer = $CardsContainer


func put_cards(new_cards: Array[AbstractCard]) -> void:
	for card in cards:
		cards_container.remove_child(card)
	
	for card in new_cards:
		cards_container.add_child(card)
	
	_spread_out_cards()


func take_cards() -> void:
	for card in cards:
		cards_container.remove_child(card)
	
	cards_container.queue_sort()


func _spread_out_cards() -> void:
	await get_tree().process_frame
	var offset_card_to_center: Vector2 = _calculate_offset_card_to_center()
	var tween: Tween = get_tree().create_tween()\
			.set_parallel()\
			.set_ease(Tween.EASE_OUT)\
			.set_trans(Tween.TRANS_QUART)
	for card in cards:
		@warning_ignore("return_value_discarded")
		tween.tween_property(card, "position", card.position, 0.5)\
			.from(Vector2.ZERO + offset_card_to_center)


func _calculate_offset_card_to_center() -> Vector2:
	var offset_card_to_center: Vector2 = cards_container.size
	offset_card_to_center.x /= 2
	return offset_card_to_center


func _on_fold_out_cards_finished() -> void:
	for card in cards:
		cards_container.remove_child(card)
	
	cards_container.queue_sort()
