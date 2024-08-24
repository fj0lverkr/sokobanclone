extends Node2D

@onready var tile_layers: Node = $TileMapLayers
@onready var tl_floor: TileMapLayer = $TileMapLayers/TilesFloor
@onready var tl_wall: TileMapLayer = $TileMapLayers/TilesWall
@onready var tl_target: TileMapLayer = $TileMapLayers/TilesTarget
@onready var tl_box: TileMapLayer = $TileMapLayers/TilesBox
@onready var player: AnimatedSprite2D = $Player
@onready var camera: Camera2D = $Camera2D

var _total_moves: int = 0
var _player_tile: Vector2i


func _ready() -> void:
	_setup()


func _process(_delta: float) -> void:
	var md: Vector2i
	
	if Input.is_action_just_pressed("up"):
		md = Vector2i.UP
	elif Input.is_action_just_pressed("down"):
		md = Vector2i.DOWN
	elif Input.is_action_just_pressed("left"):
		md = Vector2i.LEFT
		player.flip_h = true
	elif Input.is_action_just_pressed("right"):
		md = Vector2i.RIGHT
		player.flip_h = false
	else:
		md = Vector2i.ZERO

	_move_player(md)


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


func _move_player(d: Vector2i) -> void:
	var nt: Vector2i = _player_tile + d
	if tl_wall.get_used_cells().has(nt):
		return
	
	_place_player(nt)
	_total_moves += 1


func _place_player(tile_coord: Vector2i) -> void:
	var p: Vector2i = Vector2i(
		tile_coord.x * Constants.TILE_SIZE,
		tile_coord.y * Constants.TILE_SIZE,
	)

	player.position = p
	_player_tile = tile_coord


func _place_camera() -> void:
	var used_rect: Rect2i = tl_floor.get_used_rect()
	camera.position.x = (used_rect.position.x + float(used_rect.size.x) / 2) * Constants.TILE_SIZE
	camera.position.y = (used_rect.position.y + float(used_rect.size.y) / 2) * Constants.TILE_SIZE


func _setup() -> void:
	var lns: String = GameManager._level_selected
	var level_data: LevelLayout = LevelBuilder.get_data_for_level(lns)
	var layers: LevelLayerFactory = level_data.get_level_layers()
	var player_pos: Vector2i = level_data.get_player_pos()

	_total_moves = 0
	_clear_level()

	for lt: LevelLayerFactory.LayerType in layers.get_layers():
		for tile: Vector2i in layers.get_layers()[lt]:
			_add_tile(tile, lt)

	_place_camera()

	_place_player(player_pos)
