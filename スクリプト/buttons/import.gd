extends Button

@export var node : Node
@export var text_edit : TextEdit

func _pressed() -> void:
	if text_edit.text:
		node.config.parse(text_edit.text)
		node.config.save("user://char_data.cfg")
		
