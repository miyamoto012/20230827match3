extends Node2D

var font = preload("res://assets/font/SourceCodePro-Bold.ttf")

var _field_array: Array[int]
var _width: int = 0
var _height: int = 0


func set_field_array(field_array: Array[int])->void:
	_field_array = field_array.duplicate(true)
	queue_redraw()


func set_width(width:int)->void:
	_width = width


func set_height(height:int)->void:
	_height = height


func _draw():
	_draw_tile()


func _draw_tile()->void:
	if _field_array.size() != _width * _height:
		return
		
	for ix in range(_width):
		for iy in range(_height):
			var _postion := Vector2(ix*20 + 20, iy*20 + 20)
			var _text := "%d"%_field_array[ix + iy*_height]
			draw_string(font, _postion, _text)



