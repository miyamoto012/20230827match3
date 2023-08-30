extends Area2D


const GRAVITY_Y = 0.5

const OFFSET_X = 150
const OFFSET_Y = 150
const TILE_SIZE = 150
const HEIGHT = 2



## 現在のグリッド座標.
var _grid_y:float = 0

## 落下速度.
var _velocity_y:float = 0


# グリッド座標系をワールド座標系に変換する.
func grid_to_world(gx:float, gy:float) -> Vector2:
	# タイル座標系をワールド座標に変換する.
	var wx = OFFSET_X + TILE_SIZE * gx
	var wy = OFFSET_Y + TILE_SIZE * gy
	return Vector2(wx, wy)
		
func can_fall()->bool:
	if _grid_y >= HEIGHT:
		return false
	return true

func _process(delta)->void:
	if can_fall():
		_velocity_y += GRAVITY_Y * delta
		_grid_y += _velocity_y
	else:
		_grid_y = HEIGHT
	
	position = grid_to_world(0.0, _grid_y)
