extends Node2D

@export var ball_top_offset: int = 400
@onready var ball_scene = preload("res://components/base-ball.tscn")
var ball: Ball

func _ready():
	GenerateBall()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ball != null:
		ball.global_position.x = get_global_mouse_position().x

	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT && !event.pressed: 
			DropBall()
	if event is InputEventScreenTouch:
		if !event.pressed:
			DropBall()
			
func DropBall():
	if ball == null:
		return
	ball.freeze = false
	GenerateBall()
	
func GenerateBall():
	var new_ball = ball_scene.instantiate()
	if (new_ball is Ball):
		var level_count = new_ball.level_dict.size()		
		var level = randi_range(1, level_count)
		new_ball.level = 1
		ball = new_ball
		self.add_sibling.call_deferred(ball)
		ball.global_position.y = ball_top_offset		
