class_name CardsDeck
extends Resource


@export var _packed_cards: Array[PackedScene] = []

var cards: Array[AbstractCard] = [] :
	get:
		if cards.size() == 0:
			cards = _packed_cards.map(func(card): return card.instantiate())
		
		return cards
