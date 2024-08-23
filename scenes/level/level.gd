extends Node2D

@onready var tile_layers: Node = $TileMapLayers
@onready var tl_floor: TileMapLayer = $TileMapLayers/TilesFloor
@onready var tl_wall: TileMapLayer = $TileMapLayers/TilesWall
@onready var tl_target: TileMapLayer = $TileMapLayers/TilesTarget
@onready var tl_box: TileMapLayer = $TileMapLayers/TilesBox
@onready var player: AnimatedSprite2D = $Player
@onready var camera: Camera2D = $Camera2D

var _total_moves: int = 0


func _ready() -> void:
	_setup()


func _process(_delta: float) -> void:
	pass


func _clear_level() -> void:
	for tl: TileMapLayer in tile_layers.get_children():
		tl.clear()


func _get_atlas_coord(lt: LevelLayerFactory.LayerType) -> Vector2i:
	match lt:
		LevelLayerFactory.LayerType.FLOOR:
			return Vector2i(randi_range(3, 8), Constants.TILE_SET_SOURCE_ID)
		LevelLayerFactory.LayerType.WALL:
			return Vector2i(2, Constants.TILE_SET_SOURCE_ID)
		LevelLayerFactory.LayerType.TARGET:
			return Vector2i(9, Constants.TILE_SET_SOURCE_ID)
		LevelLayerFactory.LayerType.BOX:
			return Vector2i(1, Constants.TILE_SET_SOURCE_ID)
		LevelLayerFactory.LayerType.TARGET_BOX:
			return Vector2i(0, Constants.TILE_SET_SOURCE_ID)
		_:
			return Vector2i.ZERO


func _get_real_layer(lt: LevelLayerFactory.LayerType) -> TileMapLayer:
	match lt:
		LevelLayerFactory.LayerType.FLOOR:
			return tl_floor
		LevelLayerFactory.LayerType.WALL:
			return tl_wall
		LevelLayerFactory.LayerType.TARGET:
			return tl_target
		LevelLayerFactory.LayerType.BOX:
			return tl_box
		LevelLayerFactory.LayerType.TARGET_BOX:
			return tl_box
		_:
			return


func _add_tile(coords: Vector2i, lt: LevelLayerFactory.LayerType) -> void:
	var source_tile: Vector2i = _get_atlas_coord(lt)
	var layer: TileMapLayer = _get_real_layer(lt)
	layer.set_cell(coords, Constants.TILE_SET_SOURCE_ID, source_tile)


func _setup() -> void:
	var lns: String = GameManager._level_selected
	var level_data: LevelLayout = LevelBuilder.get_data_for_level(lns)
	var layers: LevelLayerFactory = level_data.get_level_layers()
	var player_pos: Vector2i = level_data.get_player_start()

	_total_moves = 0
	_clear_level()

	for lt: LevelLayerFactory.LayerType in layers.get_layers():
		for tile: Vector2i in layers.get_layers()[lt]:
			_add_tile(tile, lt)
