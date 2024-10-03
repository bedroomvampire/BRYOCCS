extends Button

@export var node : Node3D
@export var full_name : String
@export var file_name : String
@export var string_name : String

func _pressed() -> void:
	node.config.set_value(full_name, file_name, string_name)
	node.config.save("user://char_data.cfg")
