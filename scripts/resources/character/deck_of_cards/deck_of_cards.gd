class_name DeckOfCards
extends Resource


@export var _packed_cards: Array[PackedScene] = []

var _cards: Array[AbstractCard] = []
var cards: Array[AbstractCard] :
	get:
		if _cards.size() == 0:
			_cards = _packed_cards.map(func(card): return card.instantiate())
		return _cards.duplicate()
