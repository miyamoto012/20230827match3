extends Node

const OFFSET_X = 150
const OFFSET_Y = 150
const TILE_SIZE = 150

var tile_scene = preload("res://scenes/tile.tscn")

@onready var _puzzle_area = $PuzzleArea

# グリッド座標系をワールド座標系に変換する.
func grid_to_world(x:float, y:float) -> Vector2:
	# タイル座標系をワールド座標に変換する.
	var px = OFFSET_X + TILE_SIZE * x
	var py = OFFSET_Y + TILE_SIZE * y
	return Vector2(px, py)
	
	
func _ready()->void:
	for ix in range(3):
		for iy in range(3):
			var taile_instance = tile_scene.instantiate() as Area2D
			taile_instance.position = grid_to_world(ix, iy)
			_puzzle_area.add_child(taile_instance)
