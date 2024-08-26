extends Node

const SCORE_FILE_PATH: String = "user://SOKOBAN.dat"

var _scores: Dictionary


func _ready() -> void:
	_load_scores()


func _load_scores() -> void:
	if not FileAccess.file_exists(SCORE_FILE_PATH):
		return

	var f: FileAccess = FileAccess.open(SCORE_FILE_PATH, FileAccess.READ)
	if JSON.parse_string(f.get_as_text()) is Dictionary:
		_scores = JSON.parse_string(f.get_as_text())
	f.close()


func get_scores() -> Dictionary:
	return _scores


func get_score_for_level(l: String) -> int:
	if l in _scores:
		return _scores[l]
	else:
		return -1


func save_score_for_level(l: String, s: int) -> void:
	if not l in _scores or _scores[l] < s:
		_scores[l] = s
	
	var data: String = JSON.stringify(_scores)
	var f: FileAccess = FileAccess.open(SCORE_FILE_PATH, FileAccess.WRITE)
	f.store_string(data)
	f.close()
