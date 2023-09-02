extends Node2D

class_name TileObject

const GRAVITY_Y = 0.1
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


# グリッド座標系をワールド座標系に変換する.
func grid_to_world(gx:float, gy:float) -> Vector2:
	# タイル座標系をワールド座標に変換する.
	var wx = OFFSET_X + TILE_SIZE * gx
	var wy = OFFSET_Y + TILE_SIZE * gy
	return Vector2(wx, wy)


func is_collision_under_tile()->bool:
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
#			# 更新タイミングの関係でめり込んでいたら押し返す.
#			_grid_y -= (myself_bottom - other_upper)
#
			return true
			
	return false
	
	
		

	
func round_grid() -> void:
	_grid_x = round(_grid_x)
	_grid_y = round(_grid_y)


func get_grid_x() -> float:
	return _grid_x
func get_grid_y() -> float:
	return _grid_y
	
	
func spawn_setting(x:float, y:float)->void:
	_grid_y = y
	_grid_x	= x
	update_position()
	

func update_position():
	position = grid_to_world(_grid_x, _grid_y)



func can_fall()->bool:
	if _grid_y >= HEIGHT:
		return false
	if is_collision_under_tile():
		return false
		
	
	return true


func _process(delta)->void:
	_velocity_y += GRAVITY_Y * delta
	_grid_y += _velocity_y
		
	match _state:
		eState.FALLING:
			if ! can_fall():
				print("stanbay")
				round_grid()
				_velocity_y = 0.0
				_state = eState.STANDBY
		eState.STANDBY:
			if can_fall():
				_state = eState.FALLING
				print("can fall")
			else:
				_velocity_y = 0.0
				round_grid()

	update_position()
