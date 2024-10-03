extends Button

@export var node : Node3D
@export var target : MeshInstance3D
@export var full_name : String
@export var file_name : String
@export var file_name_2 : String
@export var mesh : Mesh
var boolean : bool

func _process(delta: float) -> void:
	if node.config.get_value(full_name, file_name_2):
		boolean = !node.config.get_value(full_name, file_name_2)
		button_pressed = node.config.get_value(full_name, file_name_2)

func _pressed() -> void:
	if !target.visible:
		target.visible = true
		boolean = true
		node.config.set_value(full_name, file_name_2, boolean)
	elif target.mesh == mesh:
		target.visible = false
		boolean = false
		node.config.set_value(full_name, file_name_2, boolean)
	if target.mesh != mesh:
		target.mesh = mesh
		node.config.set_value(full_name, file_name, mesh)
	#ResourceSaver.save(mesh, "user://yes.cfg")
	node.config.save("user://char_data.cfg")
