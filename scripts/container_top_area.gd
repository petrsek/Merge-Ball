class_name ContainerTopArea
extends Area2D
## This [Area2D] detects overlapping [PhysicsBody2D] and 
## controls [member ContainerTopArea.timer_to_countdown] base on
## overlapping body count

## The timer which is activated when there are bodies in this area
## [br][br]
## [b]Note:[/b] This timer should act as a time buffer to filter out
## bodies only falling through the area. 
## It does not handle actual game over timeout.
@export var timer_to_countdown: Timer

signal stop_countdown ## Emitted when all bodies leave the area


func _physics_process(_delta: float) -> void:
	var collider_count = get_overlapping_bodies().size()
	if (collider_count > 0) and timer_to_countdown.is_stopped():
		timer_to_countdown.start()
	elif collider_count == 0 and !timer_to_countdown.is_stopped():
		timer_to_countdown.stop()
		stop_countdown.emit()
	
