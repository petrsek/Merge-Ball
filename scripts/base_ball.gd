class_name Ball
extends RigidBody2D
## Represents a ball and its functionality
##
## Handles collison checking, ball behaviour and 
## setting all its nodes to correct level

## Emitted on collision with another [Ball] with identical [member Ball.level]
signal collision_with_same_ball(ball1: Ball, ball2: Ball)

@export var base_draw_component: Node2D ## Node handling drawing
@export var collider: CollisionShape2D ## Node handling collisions
@export var level: int = 0 ## Level of this ball
		
func _ready():
	UpdateLevel()

## lookup table for ball radiuses based on level
const level_dict = [
	40,
	50, 
	60, 
	75, 
	90, 
	110, 
	130, 
	150, 
	175,
	200
	]

## Sets this ball and its components to current level
func UpdateLevel():
	level = level % level_dict.size() # resets level to 0 when max reached
	var r = level_dict[level % level_dict.size()]
	base_draw_component.radius = r
	base_draw_component.level = level
	var collider_shape = CircleShape2D.new()
	collider_shape.radius = r
	collider.shape = collider_shape
	mass = r # not realistic, but feels better

func _on_body_entered(body):
	if body is Ball && self.level == body.level:
		collision_with_same_ball.emit(self, body)

## Unfreezes the ball and lets it drop and interact with environment
func Drop():
	self.freeze = false
	collider.disabled = false
