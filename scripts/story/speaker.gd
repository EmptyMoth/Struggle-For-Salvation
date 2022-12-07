extends Resource
class_name Speaker


enum Expressions {
	EXPRESSION_DEFAULT = 0,
	EXPRESSION_ANGRY = 1
}


@export var name: String = ""
@export var role: String = ""
@export var key: String = ""
@export var image: Texture = load("res://sprites/UI/story_ui/characters/test_char.png")
@export var shadow: Texture = load("res://sprites/UI/story_ui/characters/test_char_shadow.png")
@export var expressions: Dictionary = {
	Expressions.EXPRESSION_DEFAULT: load("res://sprites/UI/story_ui/characters/expressions/test_char_default.png"),
	Expressions.EXPRESSION_ANGRY: load("res://sprites/UI/story_ui/characters/expressions/test_char_angry.png")
}


func _ready() -> void:
	pass


func init(init_name: String, init_role: String, init_image: String) -> void:
	name = init_name
	role = init_role
	image = load("res://sprites/UI/story_ui/characters/%s.png" % init_image)
	shadow = load("res://sprites/UI/story_ui/characters/%s_shadow.png" % init_image)
	expressions[Expressions.EXPRESSION_DEFAULT] = load("res://sprites/UI/story_ui/characters/expressions/%s_default.png" % init_image)
	expressions[Expressions.EXPRESSION_ANGRY] = load("res://sprites/UI/story_ui/characters/expressions/%s_angry.png" % init_image)

