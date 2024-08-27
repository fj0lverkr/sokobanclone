class_name LevelCompletePanel

extends CanvasLayer

@onready var moves_label: Label = $MC/VB/HBMoves/LabelMoves
@onready var best_hb: HBoxContainer = $MC/VB/HBBest

var _lns: String


func _ready() -> void:
	best_hb.hide()
	_lns = GameManager.get_selected_level()


func set_current_moves(m: int) -> void:
	moves_label.text = str(m)
	_check_best_moves(m)


func _check_best_moves(m: int) -> void:
	var hs: int = ScoreManager.get_score_for_level(_lns)
	if m <= hs:
		return

	best_hb.show()
