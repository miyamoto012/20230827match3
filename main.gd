extends Node

const OFFSET_X = 150
const OFFSET_Y = 150
const TILE_SIZE = 150

var tile_scene = preload("res://scenes/tile.tscn")
@onready var _puzzle_area = $PuzzleArea
@onready var _debug_display = $DebugDisplay
@onready var _field_manager = $FieldManager


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
	tile_instance2.start_fall.connect(_on_tile_start_fall)
	tile_instance2.stop_fall.connect(_on_tile_stop_fall)
	
	var tile_instance = tile_scene.instantiate() as Node2D
	tile_instance.spawn_setting(0.0, -1.0)
	_puzzle_area.add_child(tile_instance)
	tile_instance.start_fall.connect(_on_tile_start_fall)
	tile_instance.stop_fall.connect(_on_tile_stop_fall)
	
	_field_manager.initialize_array()
	
	_debug_display.set_width(_field_manager.WIDTH)
	_debug_display.set_height(_field_manager.HEIGHT)
	_debug_display.set_field_array(_field_manager.get_field_array())


func _on_tile_start_fall(grid_x: int, grid_y: int):
	print("fall start")
	

func _on_tile_stop_fall(grid_x: int, grid_y: int):
	print("fall stop")



