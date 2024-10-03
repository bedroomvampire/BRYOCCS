extends Button

@export var node : Node
@export var web : bool

func _ready() -> void:
	if OS.has_feature("web") && !web:
		visible = false

func _on_pressed() -> void:
	if node:
		if !node.visible:
			node.visible = true
		else:
			node.visible = false
