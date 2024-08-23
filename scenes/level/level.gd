extends Node2D

@onready var tile_layers: Node = $TileMapLayers
@onready var tl_floor: TileMapLayer = $TileMapLayers/TilesFloor
@onready var tl_wall: TileMapLayer = $TileMapLayers/TilesWall
@onready var tl_target: TileMapLayer = $TileMapLayers/TilesTarget
@onready var tl_box: TileMapLayer = $TileMapLayers/TilesBox
@onready var player: AnimatedSprite2D = $Player

var _total_moves: int = 0


func _ready() -> void:
	_setup()


func _process(_delta: float) -> void:
	pass


func _clear_level() -> void:
	for tl: TileMapLayer in tile_layers.get_children():
		tl.clear()


func _setup() -> void:
	var lns: String = GameManager._level_selected
	var level_data: LevelLayout = LevelBuilder.get_data_for_level(lns)
	var layers: LevelLayerFactory = level_data.get_level_layers()
	var player_pos: Vector2i = level_data.get_player_start()

	_total_moves = 0
	_clear_level()
