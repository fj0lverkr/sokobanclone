class_name LevelButton
extends NinePatchRect

@onready var label: Label = $LevelLabel
@onready var check_completed: TextureRect = $CheckMark

var _button_level: String = "1"
var _level_completed: bool = false


func _ready() -> void:
	if _level_completed:
		check_completed.show()
	
	label.text = _button_level


func set_button_level(ln: String) -> void:
	_button_level = ln
	_level_completed = ScoreManager.get_score_for_level(ln) > -1


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click_left"):
		SignalBus.on_level_selected.emit(_button_level)
