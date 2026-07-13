class_name Circle2D
extends Node2D
## 2D Component which draws a circle.
##
## This component draws a circle of 
## [member Circle2D.radius] radius with center at this components
## [member Node2D.position][br]
## The colour is picked based on [member Circle2D.level] from
## [member Circle2D.color_lut]

@export var radius: int: ## The radius of the circle (in pixels)
	set(val):
		radius = val
		queue_redraw()
		
@export var level: int = 0: ## The level of the ball (for colour picking)
	set(val):
		level = val
		queue_redraw()
		
## The lookup table for picking color 
## [br][br]
## [b]Note:[/b] The level does not necessarily 
## have to match [member color_lut.size()].
@export var color_lut: Array[Color] = [
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
