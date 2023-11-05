class_name AbstractKeyword
extends Resource


static func get_str_keyword() -> String:
	return "[hint=%s][color=%s]%s[/color][/hint]" % [get_description(), get_color(), get_title()]


static func get_title() -> String:
	return ""


static func get_description() -> String:
	return ""


static func get_color() -> String:
	return ""
