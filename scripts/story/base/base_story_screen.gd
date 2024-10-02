class_name BaseStoryScreen
extends Node2D


@onready var location_label: Label = $CanvasLayer/MarginContainer/VBoxContainer/LocationTitle
@onready var name_label: Label = $CanvasLayer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/CharacterName
@onready var dialog_label: KeywordsRichTextLabel = $CanvasLayer/MarginContainer/VBoxContainer/VBoxContainer/PanelContainer/KeywordsRichTextLabel


func set_dialog_data(dialog_data: DialogData) -> void:
	location_label.text = dialog_data.location_title
	name_label.text = dialog_data.character_name
	dialog_label.text = dialog_data.character_phrase


class DialogData:
	var location_title: String
	var character_name: String
	var character_phrase: String
