extends Button

@export var node : Node3D
@export var target : MeshInstance3D
@export var full_name : String
@export var file_name : String
@export var mesh : Mesh
@export var mesh_2 : Mesh
var boolean : bool = true

func _process(delta: float) -> void:
	#boolean = !node.config.get_value(full_name, file_name)
	#button_pressed = !boolean
	pass

func _pressed() -> void:
	if !boolean:
		boolean = true
	else:
		boolean = false
	target.mesh = mesh
	node.config.set_value(full_name, file_name, mesh)
	#ResourceSaver.save(mesh, "user://yes.cfg")
	node.config.save("user://char_data.cfg")
