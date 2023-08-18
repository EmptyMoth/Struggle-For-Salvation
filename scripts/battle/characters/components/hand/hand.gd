class_name Hand
extends Resource


var cards: Array[AbstractCard] = []


func _init(deck_of_cards: DeckOfCards) -> void:
	cards = deck_of_cards.cards


func update() -> void:
	for card in cards:
		card.update()


func get_random_card() -> AbstractCard:
	return cards.pick_random()


func get_random_active_card() -> AbstractCard:
	var active_cards: Array[AbstractCard] = _get_active_cards()
	return active_cards.pick_random() if active_cards.size() != 0 else null


func _get_active_cards() -> Array[AbstractCard]:
	return cards.filter(func (card: AbstractCard): return card.can_use())
