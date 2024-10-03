extends Button

@export var node : Node
@export var text_edit : TextEdit

func _pressed() -> void:
	text_edit.clear()
	var text = node.config.encode_to_text()
	text_edit.text = text
