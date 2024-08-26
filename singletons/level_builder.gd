extends Node

var _level_data: Dictionary


func _ready() -> void:
	_load_data()


func _load_data() -> void:
	var file: FileAccess = FileAccess.open(Constants.LEVEL_DATA_PATH, FileAccess.READ)
	var raw_data: Dictionary = JSON.parse_string(file.get_as_text())
	for lns: String in raw_data.keys():
		_level_data[lns] = LevelLayout.new(raw_data[lns])
	file.close()


func get_data_for_level(level: String) -> LevelLayout:
	if not _level_data.has(level):
		print("No data for level %s" % level)
		return
	return _level_data[level]


func get_num_levels() -> int:
	return _level_data.size()