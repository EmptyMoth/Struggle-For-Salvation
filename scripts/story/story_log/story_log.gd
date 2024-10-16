class_name StoryLog
extends PanelContainer


const _SPEAKER_DIALOGS_IN_LOG: PackedScene = preload("res://scenes/story/story_log/speaker_dialogs_in_log.tscn")

var closed_log: Signal :
	get: return $Margin/VBox/Header/Margin/HBox/BackButton.pressed

var _last_speaker: SpeakingCharacter
var _last_dialogs: PackedStringArray = []
var _current_speaker_dialogs_log: SpeakerDialogsLog

@onready var _dialogs_container: VBoxContainer = $Margin/VBox/Main/SmoothScroll/Margin/VBox
@onready var _smooth_scroll: ScrollContainer = $Margin/VBox/Main/SmoothScroll


func open() -> void:
	modulate.a = 1
	show()
	await get_tree().process_frame
	_smooth_scroll.scroll_to_bottom(0)


func close() -> void:
	await create_tween().tween_property(self, "modulate:a", 0, 0.1).finished
	hide()


func add_log(speaker: SpeakingCharacter, dialog: String) -> void:
	if speaker != _last_speaker:
		_last_speaker = speaker
		_last_dialogs = [dialog]
		_current_speaker_dialogs_log = _SPEAKER_DIALOGS_IN_LOG.instantiate()
		_dialogs_container.add_child(_current_speaker_dialogs_log)
	else:
		_last_dialogs.append(dialog)
	
	if not _current_speaker_dialogs_log.is_node_ready():
		await _current_speaker_dialogs_log.ready
	_current_speaker_dialogs_log.set_speaker(_last_speaker, _last_dialogs)
