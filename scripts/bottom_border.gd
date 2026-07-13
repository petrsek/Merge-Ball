class_name BottomBorder
extends Area2D
## [Area2D] that frees all bodies that enter it 
## and ends game when that happens

@export var game_over_timer : Timer ## Timer responsible for ending game

func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
	game_over_timer.timeout.emit()
