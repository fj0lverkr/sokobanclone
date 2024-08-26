class_name LevelButton
extends NinePatchRect

@onready var label: Label = $LevelLabel

var _button_level: String = "1"


func _ready() -> void:
	label.text = _button_level


func set_button_level(ln: String) -> void:
	_button_level = ln


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click_left"):
		SignalBus.on_level_selected.emit(_button_level)
