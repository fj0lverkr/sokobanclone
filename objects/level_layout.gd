class_name LevelLayout

var _player_start: Vector2i
var _level_layers: LevelLayerFactory


func _init(d: Dictionary) -> void:
    _player_start = Vector2i(d.player_start.x, d.player_start.y)
    _level_layers = LevelLayerFactory.new(d.tiles)


func get_player_pos() -> Vector2i:
    return _player_start


func get_level_layers() -> LevelLayerFactory:
    return _level_layers