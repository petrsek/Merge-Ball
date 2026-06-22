extends Node2D

@export var ball_top_offset: int = 400
@onready var ball_scene = preload("res://components/base-ball.tscn")
var ball: Ball

func _ready():
	ReadyBall()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ball != null:
		ball.global_position.x = GetMouseXPos()
		
func GetMouseXPos():
	return clampf(get_global_mouse_position().x, 200, 880)

	
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
	ball.Drop()
	ball = null
	await get_tree().create_timer(.5).timeout
	ReadyBall()

## Generates a new ball and saves it to the [ball] variable
##
## Ball is generated at y = [ball_top_offset] and x = global_mous_position.x
## Level is random
func ReadyBall():
	var level = GetNextLevel()
	var glob_pos = Vector2(GetMouseXPos(), ball_top_offset)
	var new_ball = CreateBall(glob_pos, level)
	ball = new_ball
	self.add_sibling.call_deferred(ball)
		
func CreateBall(glob_pos: Vector2, level: int):
	var new_ball: Ball = ball_scene.instantiate()
	assert(new_ball is Ball)
	new_ball.collision_with_same_ball.connect(_on_same_ball_collision)
	new_ball.level = level
	new_ball.global_position = glob_pos
	return new_ball


func _on_same_ball_collision(ball1: Ball, ball2: Ball):
	if ball1.is_queued_for_deletion() || ball2.is_queued_for_deletion():
		return
	var pos = (ball1.global_position + ball2.global_position) / 2
	var level = (ball1.level + 1) % Ball.level_dict.size()
	ball1.queue_free()
	ball2.queue_free()
	var new_ball = CreateBall(pos, level)
	new_ball.Drop()
	self.add_sibling.call_deferred(new_ball)
	
func GetNextLevel():
	var rand = randf()
	var level: int = 4
	for i in range(1, 6):
		if rand > 1 / float(i + 1):
			level = i - 1
			break
	return level
