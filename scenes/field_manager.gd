extends Node

var field_array: Array[int]
const WIDTH:int = 3
const HEIGHT:int = 3


func initialize_array():
	field_array.resize(WIDTH*HEIGHT)
	field_array.fill(0)
	

func get_field_array()->Array[int]:
	return field_array

