extends Node

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("F11"):
		if DisplayServer.window_get_mode() == 0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
