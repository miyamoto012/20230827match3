extends Node

var field_array: Array[int]
const WIDTH:int = 3
const HEIGHT:int = 3


func initialize_array():
	field_array.resize(WIDTH*HEIGHT)
	field_array.fill(0)
	

func get_field_array()->Array[int]:
	return field_array
	
	
func update_field_array(update_value: int, x: int, y: int)->void:
	if  x < 0 || WIDTH <= x:
		return
		
	if  y < 0 || HEIGHT <= y:
		return
	
	field_array[x + y * WIDTH] = update_value

