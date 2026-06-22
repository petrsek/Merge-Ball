class_name Ball

extends RigidBody2D

signal collision_with_same_ball(ball1: Ball, ball2: Ball)

@export var base_draw_component: Node2D
@export var collider: CollisionShape2D
@export var level: int = 0
		
func _ready():
	UpdateLevel()

const level_dict = [
	20,
	25, 
	35, 
	50, 
	65, 
	80, 
	100, 
	125, 
	150,
	175
	]

func UpdateLevel():
	var r = level_dict[level % level_dict.size()]
	base_draw_component.radius = r
	base_draw_component.level = level
	var collider_shape = CircleShape2D.new()
	collider_shape.radius = r
	collider.shape = collider_shape
	mass = r

func _on_body_entered(body):
	if body is Ball && self.level == body.level:
		collision_with_same_ball.emit(self, body)
	
func Drop():
	self.freeze = false
	collider.disabled = false
