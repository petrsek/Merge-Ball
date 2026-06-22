extends Area2D

@export var timer_to_countdown: Timer

signal stop_countdown

func _physics_process(_delta: float) -> void:
	var collider_count = get_overlapping_bodies().size()
	if (collider_count > 0) and timer_to_countdown.is_stopped():
		timer_to_countdown.start()
	elif collider_count == 0 and !timer_to_countdown.is_stopped():
		timer_to_countdown.stop()
		stop_countdown.emit()
	
