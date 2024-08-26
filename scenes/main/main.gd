extends Control

const LEVEL_BUTTON: PackedScene = preload("res://scenes/level_button/level_button.tscn")

@onready var grid: GridContainer = $MC/VB/LevelGridContainer

@export var num_cols: int = 6


func _ready() -> void:
	_setup_grid()


func _setup_grid() -> void:
	var num_levels: int = LevelBuilder.get_num_levels()
	grid.columns = num_cols
	for l: int in range(num_levels):
		var button: LevelButton = LEVEL_BUTTON.instantiate()
		button.set_button_level(str(l + 1))
		grid.add_child(button)
