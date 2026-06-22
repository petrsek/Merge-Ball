extends Node2D

@export var radius: int:
	set(val):
		radius = val
		queue_redraw()
		
@export var level: int = 0:
	set(val):
		level = val
		queue_redraw()
const color_lut: Array[Color] = [
	Color("6797ffff"), 
	Color("ffffffff"),
	Color("c300e5ff"), 
	Color("3bff00ff"),
	Color("fe0034ff"), 
	Color("00ffeeff"), 
	Color("d9ff00ff"), 
	Color("000000ff"), 
	Color("ff0088ff"), 
	Color("51cc79ff")
	]

func _draw():
	draw_circle(position, radius, color_lut[level % color_lut.size()], true)
