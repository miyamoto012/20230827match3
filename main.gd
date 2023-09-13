extends Node

const OFFSET_X = 150
const OFFSET_Y = 150
const TILE_SIZE = 150

const TILE_SCENE = preload("res://scenes/tile.tscn")
@onready var _debug_display = $DebugDisplay
@onready var _board_manager = $BoardManager


# グリッド座標系をワールド座標系に変換する.
func grid_to_world(gx:float, gy:float) -> Vector2:
	# タイル座標系をワールド座標に変換する.
	var wx = OFFSET_X + TILE_SIZE * gx
	var wy = OFFSET_Y + TILE_SIZE * gy
	return Vector2(wx, wy)
	

func _ready()->void:
	
	_board_manager.spawn_tiles()
	
	
	_debug_display.set_width(_board_manager.WIDTH)
	_debug_display.set_height(_board_manager.HEIGHT)
	_debug_display.set_board_array(_board_manager.get_board_array())

func _process(delta):
	_execute_tiles_manual_process()
	
	_debug_display.set_board_array(_board_manager.get_board_array())


func _execute_tiles_manual_process()->void:
	var tiles = get_tree().get_nodes_in_group("tile")
	
	if tiles.size() == 0:
		return
		
	# 不要な衝突判定を避けるために下にあるタイルが先に動くようにしたい
	tiles.sort_custom(func(a: TileObject, b: TileObject):
		var a_grid_y = a.get_grid_y()
		var b_grid_y = b.get_grid_y()
		return a_grid_y > b_grid_y
	)
	
	
	print("=====fall set========")
	print("tiles:%d"%tiles.size())
	for tile in tiles:
		tile.manual_process()
	print("===========")
		




