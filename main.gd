extends Node

const OFFSET_X = 150
const OFFSET_Y = 150
const TILE_SIZE = 150

var tile_scene = preload("res://scenes/tile.tscn")

@onready var _puzzle_area = $PuzzleArea


# グリッド座標系をワールド座標系に変換する.
func grid_to_world(gx:float, gy:float) -> Vector2:
	# タイル座標系をワールド座標に変換する.
	var wx = OFFSET_X + TILE_SIZE * gx
	var wy = OFFSET_Y + TILE_SIZE * gy
	return Vector2(wx, wy)
	

func _ready()->void:
	var tile_instance2 = tile_scene.instantiate() as Node2D
	tile_instance2.spawn_setting(0.0, 0.0)
	_puzzle_area.add_child(tile_instance2)
	
	var tile_instance = tile_scene.instantiate() as Node2D
	tile_instance.spawn_setting(0.0, -1.0)
	_puzzle_area.add_child(tile_instance)
	


