class_name LevelLayerFactory

enum LayerType {
    FLOOR,
    WALL,
    TARGET,
    BOX,
    TARGET_BOX,
    INVALID
}

var _floor: Array[Vector2i]
var _wall: Array[Vector2i]
var _target: Array[Vector2i]
var _box: Array[Vector2i]
var _target_box: Array[Vector2i]

var _level_layers: Dictionary = {
    LayerType.FLOOR: _floor,
    LayerType.WALL: _wall,
    LayerType.TARGET: _target,
    LayerType.BOX: _box,
    LayerType.TARGET_BOX: _target_box,
}


func _init(tile_data: Dictionary) -> void:
    for lts: String in tile_data:
        var lt: LayerType = _get_type_for_layer(lts)
        if not lt == LayerType.INVALID:
            for c: Dictionary in tile_data[lts]:
                _add_coord(Vector2i(c.x, c.y), lt)
        else:
            print("Invalid layer type: %s" % lts)


func _get_type_for_layer(lt: String) -> LayerType:
    match lt:
        "Floor": return LayerType.FLOOR
        "Walls": return LayerType.WALL
        "Targets": return LayerType.TARGET
        "Boxes": return LayerType.BOX
        "TargetBoxes": return LayerType.TARGET_BOX
        _: return LayerType.INVALID


func _add_coord(c: Vector2i, t: LayerType) -> void:
    _level_layers[t].push_back(c)


func get_layers() -> Dictionary:
    return _level_layers