extends Node2D

var _board_array: Array[int] = []
var _number_of_tiles_x: Array[int] = []

const WIDTH: int = 3
const HEIGHT: int = 3
const NONE: int = -1
const TILE_SCENE = preload("res://scenes/tile.tscn")
const MAX_NUM_OF_TILES_IN_X: int = 3


func _ready()->void:
	_initialize_board_array()
	_initialize_number_of_tiles_x()


func _initialize_board_array():
	_board_array.resize(WIDTH*HEIGHT)
	_board_array.fill(NONE)


func _initialize_number_of_tiles_x():
	_number_of_tiles_x.resize(WIDTH)
	_number_of_tiles_x.fill(0)


func get_board_array()->Array[int]:
	return _board_array
	
	
func _update_board_array(update_value: int, x: int, y: int)->void:
	if  x < 0 || WIDTH <= x:
		return
	if  y < 0 || HEIGHT <= y:
		return
	
	_board_array[x + y * WIDTH] = update_value


func spawn_tiles()->void:
	for i_x in range(WIDTH):
		var spawn_num: int = MAX_NUM_OF_TILES_IN_X - _number_of_tiles_x[i_x]
		
		for i_s in range(spawn_num):
			var tile_instance = TILE_SCENE.instantiate() as Node2D
			add_child(tile_instance)
			tile_instance.spawn_setting(float(i_x), 1 + -1*i_s)	
			tile_instance.start_fall.connect(_on_tile_start_fall)
			tile_instance.stop_fall.connect(_on_tile_stop_fall)
			_number_of_tiles_x[i_x] += 1
	


func _on_tile_start_fall(grid_x: int, grid_y: int):
	_update_board_array(NONE, grid_x, grid_y)


func _on_tile_stop_fall(type_id: int, grid_x: int, grid_y: int):
	_update_board_array(type_id, grid_x, grid_y)

