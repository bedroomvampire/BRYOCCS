extends "res://スクリプト/buttons/colour_picker.gd"

@export var toggle : Button

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if toggle.button_pressed:
		visible = true
	else:
		visible = false
	
	if node.config.get_value(full_name, file_name):
		color = node.config.get_value(full_name, file_name)
