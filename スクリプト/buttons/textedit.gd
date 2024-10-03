extends LineEdit

@export var node : Node
@export var full_name : String
@export var file_name : String
var focus : bool

func _ready() -> void:
	if node.config.get_value(full_name, file_name):
		text = node.config.get_value(full_name, file_name)

func _on_text_submitted(new_text: String) -> void:
	node.config.set_value(full_name, file_name, new_text)
	node.config.save("user://char_data.cfg")
