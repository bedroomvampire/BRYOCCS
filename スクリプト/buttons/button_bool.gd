extends Button

@export var node : Node3D
@export var full_name : String
@export var file_name : String
var boolean : bool = true

func _process(delta: float) -> void:
	if node.config.get_value(full_name, file_name):
		boolean = !node.config.get_value(full_name, file_name)
		button_pressed = node.config.get_value(full_name, file_name)

func _pressed() -> void:
	node.config.set_value(full_name, file_name, boolean)
	if !boolean:
		boolean = true
	else:
		boolean = false
	node.config.save("user://char_data.cfg")
