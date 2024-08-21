extends Node

var _level_data: Dictionary # level:LevelLayout

func _ready() -> void:
    _load_data()

func _load_data() -> void:
    var file: FileAccess = FileAccess.open(Constants.LEVEL_DATA_PATH, FileAccess.READ)
    var raw_data: Dictionary = JSON.parse_string(file.get_as_text())
    for lns in raw_data.keys:
        pass
    file.close()
