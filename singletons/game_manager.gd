extends Node

const MAIN_SCENE: PackedScene = preload("res://scenes/main/main.tscn")
const LEVEL_SCENE: PackedScene = preload("res://scenes/level/level.tscn")

var _level_selected: String = "1"


func _ready() -> void:
    SignalBus.on_level_selected.connect(_on_level_selected)


func _on_level_selected(l: String) -> void:
    _level_selected = l
    get_tree().change_scene_to_packed(LEVEL_SCENE)


func go_to_main() -> void:
    get_tree().change_scene_to_packed(MAIN_SCENE)


func get_selected_level() -> String:
    return _level_selected