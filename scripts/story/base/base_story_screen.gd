class_name BaseStoryScreen
extends Node2D


const _SPEAKER_SCENE: PackedScene = preload("res://scenes/story/speakers/base_speaker.tscn")

@export var _visual_scenario: VisualScenario

@export_group("Connections")
@export var _background: Sprite2D
@export var _location_label: Label
@export var _speaker_name_label: Label
@export var _dialog_label: KeywordsRichTextLabel
@export var _story_ui: Control
@export var _story_log: StoryLog

var _last_text_id: int = 0
var _stage_data: StageData

var _text_id: int = 0
var _is_autoplay_text: bool = false
var _current_speaker: SpeakingCharacter
var _speakers_by_characters: Dictionary = {}


func _ready() -> void:
	_story_log.closed_log.connect(_on_closed_log)
	_stage_data = StageData.new(1, 1, "PRE")
	_last_text_id = 15
	_start_dialog()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_next_story_dialog") and not _story_log.visible:
		_react_to_main_player_action()


func _react_to_main_player_action() -> void:
	if not _story_ui.visible:
		_turn_off_viewing_state()
	elif _dialog_label.visible_ratio != 1:
		_is_autoplay_text = false
		_dialog_label.visible_ratio = 1
	else:
		_switch_to_next_dialog()


func _start_dialog() -> void:
	var dialog_key: String = _create_dialog_key()
	_dialog_label.set_keywords_text(dialog_key)
	_autoplay_write()
	_implement_dialog_visual(_visual_scenario.get_next_visual_dialog_or_null(_text_id))
	_story_log.add_log(_current_speaker, dialog_key)


func _finish_story() -> void:
	GlobalParameters.change_scene_with_transition("res://tests/battle/test_battle.tscn")


func _autoplay_write() -> void:
	_is_autoplay_text = true
	_dialog_label.visible_characters = 0
	for i: int in len(_dialog_label.text):
		if not _is_autoplay_text:
			return
		_dialog_label.visible_characters += 1
		await get_tree().create_timer(0.03).timeout
	_is_autoplay_text = false


func _switch_to_next_dialog() -> void:
	if _text_id >= _last_text_id:
		_finish_story()
		return
	_text_id += 1
	_start_dialog()


func _create_dialog_key() -> String:
	return "STORY_DIALOG_%s_%s_%s_%s" % \
		[_stage_data.chapter, _stage_data.show_time, _stage_data.stage, _text_id]


func _implement_dialog_visual(dialog_visual: BaseDialog) -> void:
	if dialog_visual == null:
		return
	if dialog_visual.location != null:
		_set_location(dialog_visual.location)
	for character: SpeakerSetup in dialog_visual.speakers:
		_set_character(character)
	for speaker: Speaker in _speakers_by_characters.values():
		_set_speaker(speaker, dialog_visual)


func _set_location(location: StoryLocation) -> void:
	_location_label.text = location.title
	_background.texture = location.background


func _set_speaker(speaker: Speaker, dialog_visual: BaseDialog) -> void:
		var speaker_modulate: Color = Color.WEB_GRAY
		if speaker.speaker == dialog_visual.current_speaker:
			_current_speaker = speaker.speaker
			speaker_modulate = Color.WHITE
			_speaker_name_label.text = speaker.speaker.name_character
		speaker.modulate = speaker_modulate


func _set_character(speaker: SpeakerSetup) -> void:
	match speaker.action:
		SpeakerSetup.ActionWithSpeaker.ADD:
			var speaker_scene: Speaker = _SPEAKER_SCENE.instantiate()
			speaker_scene.set_speaker_setup(speaker)
			$Speakers.add_child(speaker_scene)
			_speakers_by_characters[speaker.speaker] = speaker_scene
		SpeakerSetup.ActionWithSpeaker.REMOVE:
			var speaker_scene: Speaker = _speakers_by_characters[speaker.speaker]
			speaker_scene.queue_free()
			_speakers_by_characters.erase(speaker.speaker)
		SpeakerSetup.ActionWithSpeaker.CHANGE:
			_speakers_by_characters[speaker.speaker].set_speaker_setup(speaker)


func _turn_off_viewing_state() -> void: _story_ui.show()


func _on_ui_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_react_to_main_player_action()


func _on_closed_log() -> void:
	_story_ui.show()
	_story_log.close()

func _on_log_button_pressed() -> void:
	#_story_ui.hide()
	_story_log.open()


func _on_skip_button_pressed() -> void: _finish_story()

func _on_view_button_pressed() -> void: _story_ui.hide()


class StageData:
	var chapter: int = 0
	var stage: int = 1
	var show_time: String = "PRE"
	
	func _init(_chapter: int, _stage: int, _show_time: String) -> void:
		chapter = _chapter
		stage = _stage
		show_time = _show_time
