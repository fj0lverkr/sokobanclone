extends Node

const MAIN_SCENE: PackedScene = preload("res://scenes/main/main.tscn")
const LEVEL_SCENE: PackedScene = preload("res://scenes/level/level.tscn")

var _level_selected: String = "1"


func _ready() -> void:
    SignalBus.on_level_selected.connect(_on_level_selected)
    SignalBus.on_level_complete.connect(_on_level_complete)


func _on_level_selected(l: String) -> void:
    _level_selected = l
    get_tree().change_scene_to_packed(LEVEL_SCENE)


func _go_to_main() -> void:
    get_tree().change_scene_to_packed(MAIN_SCENE)


func _get_selected_level() -> String:
    return _level_selected


func _on_level_complete(_l: String, _m: int) -> void:
    #do stuff to save the moves for this level and the fact that it is completed
    _go_to_main()