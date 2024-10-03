extends ColorPickerButton

@export var node : Node
@export var full_name : String
@export var file_name : String

func _process(_delta: float) -> void:
	if node.config.get_value(full_name, file_name):
		color = node.config.get_value(full_name, file_name)

func _on_color_changed(color: Color) -> void:
	node.config.set_value(full_name, file_name, color)
	node.config.save("user://char_data.cfg")
