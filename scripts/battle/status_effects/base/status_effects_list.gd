class_name StatusEffectsList
extends RefCounted


enum Tags {
	TEST_EFFECT = -1,
}

static var GET_STATUS_EFFECT_BY_TAG: Dictionary = {
	Tags.TEST_EFFECT: TestStatusEffect,
}
