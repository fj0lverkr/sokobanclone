extends CanvasLayer

@onready var level_label: Label = $MC/VB/HBLevel/LabelLevel
@onready var moves_label: Label = $MC/VB/HBMoves/LabelMoves
@onready var best_label: Label = $MC/VB/HBBestMoves/LabelBestMoves

const NULL_MOVES: String = "-"

var _current_level: String = "1"
var _current_moves: int = -1


func _ready() -> void:
	SignalBus.on_moves_update.connect(_on_moves_update)
	_current_level = GameManager.get_selected_level()
	level_label.text = _current_level
	_set_best_moves()
	_set_current_moves()


func _on_moves_update(m: int) -> void:
	_current_moves = m
	_set_current_moves()

func _set_best_moves() -> void:
	var best_moves: int = ScoreManager.get_score_for_level(_current_level)
	best_label.text = str(best_moves) if best_moves > 0 else "-"


func _set_current_moves() -> void:
	moves_label.text = str(_current_moves) if _current_moves > 0 else "-"