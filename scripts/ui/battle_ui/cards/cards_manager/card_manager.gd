class_name CardManager
extends Control


var cards: Array[Node] = [] :
	get: return cards_container.get_children()

@onready var cards_container: HBoxContainer = $CardsContainer


func put_cards(cards_deck: CardsDeck) -> void:
	for card in cards:
		cards_container.remove_child(card)
	
	for card in cards_deck.cards:
		cards_container.add_child(card)
	
	await get_tree().process_frame
	_spread_out_cards()


func _spread_out_cards() -> void:
	var offset_card_to_center: Vector2 = _calculate_offset_card_to_center()
	var tween: Tween = get_tree().create_tween()
	for card in cards:
		@warning_ignore(return_value_discarded)
		tween.parallel()\
			.tween_property(card, "position", card.position, 0.5)\
			.from(Vector2.ZERO + offset_card_to_center)


func _calculate_offset_card_to_center() -> Vector2:
	var offset_card_to_center: Vector2 = cards_container.size
	offset_card_to_center.x /= 2
	return offset_card_to_center
