extends Node2D

@export var radius: int:
	set(val):
		radius = val
		queue_redraw()
		
@export var color: Color = Color("White"):
	set(val):
		color = val
		queue_redraw()

func _draw():
	draw_circle(position, radius, color, true)
