class_name MainMenu
extends Control
## Handles all main menu logic

## Loads endless mode scene
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/endless_mode.tscn")

## Quits the app
func _on_exit_button_pressed() -> void:
	get_tree().quit()
