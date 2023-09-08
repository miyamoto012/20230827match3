extends Node

var board_array: Array[int]
const WIDTH: int = 3
const HEIGHT: int = 3

const NONE: int = -1

func initialize_array():
	board_array.resize(WIDTH*HEIGHT)
	board_array.fill(NONE)
	

func get_board_array()->Array[int]:
	return board_array
	
	
func update_board_array(update_value: int, x: int, y: int)->void:
	if  x < 0 || WIDTH <= x:
		return
		
	if  y < 0 || HEIGHT <= y:
		return
	
	board_array[x + y * WIDTH] = update_value

