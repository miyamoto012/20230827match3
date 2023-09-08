extends Node2D

class_name TileObject

signal start_fall(grid_x: int, grid_y: int)
signal stop_fall(type_id: int, grid_x: int, grid_y: int)

@export var tiles_png :Array[Resource] = []
@onready var _sprite = $Sprite2D

const GRAVITY_Y = 0.005
const OFFSET_X = 150
const OFFSET_Y = 150
const TILE_SIZE = 150
const HEIGHT = 2

## タイルの状態
enum eState {
	FALLING, # 落下中.
	STANDBY, # 待機中.
}

var _state = eState.STANDBY

## 現在のグリッド座標.
var _grid_y:float = 0.0
var _grid_x:float = 0.0
## 落下速度.
var _velocity_y:float = 0.0

var _type_id:int = 0

func spawn_setting(x:float, y:float)->void:
	_type_id = randi() % tiles_png.size()
	_sprite.texture = tiles_png[_type_id]
	
	_grid_y = y
	_grid_x	= x
	_update_position()


# グリッド座標系をワールド座標系に変換する.
func grid_to_world(gx:float, gy:float) -> Vector2:
	# タイル座標系をワールド座標に変換する.
	var wx = OFFSET_X + TILE_SIZE * gx
	var wy = OFFSET_Y + TILE_SIZE * gy
	return Vector2(wx, wy)


func _is_collision_under_tile()->bool:
	var tiles = get_tree().get_nodes_in_group("tile")
	for tile in tiles :
		var instance_id = tile.get_instance_id()
		var tile_x = tile.get_grid_x()
		var tile_y = tile.get_grid_y()
		
		if get_instance_id() == instance_id:
			continue
			
		if _grid_x != tile_x:
			continue
	
		if _grid_y > tile_y:
			continue
		
		var myself_bottom = _grid_y + 0.5
		var other_upper = tile_y - 0.5
		if myself_bottom > other_upper:
			return true
		
	return false


func floorf_grid() -> void:
	_grid_x = floorf(_grid_x)
	_grid_y = floorf(_grid_y)


func get_grid_x() -> float:
	return _grid_x
func get_grid_y() -> float:
	return _grid_y
	

func _update_position():
	position = grid_to_world(_grid_x, _grid_y)


func _can_fall()->bool:
	if _grid_y >= HEIGHT:
		return false
	if _is_collision_under_tile():
		return false
	
	return true




func _ready()->void:
	pass


func manual_process()->void:
	_velocity_y += GRAVITY_Y * get_process_delta_time()
	_grid_y += _velocity_y
		
	match _state:
		eState.FALLING:
			if ! _can_fall():
				floorf_grid()
				_velocity_y = 0.0
				_state = eState.STANDBY
				print("x%d"%floori(_grid_x))
				print("y%d"%floori(_grid_y))
				emit_signal("stop_fall", _type_id, floori(_grid_x), floori(_grid_y))
		eState.STANDBY:
			if _can_fall():
				_state = eState.FALLING
				emit_signal("start_fall", floori(_grid_x), floori(_grid_y))
			else:
				_velocity_y = 0.0
				floorf_grid()

	_update_position()

