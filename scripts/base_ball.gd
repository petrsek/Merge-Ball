class_name Ball

extends RigidBody2D

@export var base_draw_component: Node2D
@export var collider: CollisionShape2D


@export var level: int = 1
		
func _ready():
	UpdateLevel()

const level_dict = {
	1:25,
	2:50,
	3:75,
	4:100,
	5:150
}

func UpdateLevel():
	base_draw_component.radius = level_dict[level]
	var collider_shape = CircleShape2D.new()
	collider_shape.radius = level_dict[level]
	collider.shape = collider_shape


func _on_body_entered(body):
	pass # Replace with function body.
