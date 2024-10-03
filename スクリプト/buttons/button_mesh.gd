extends Button

@export var node : Node3D
@export var target : MeshInstance3D
@export var full_name : String
@export var file_name : String
@export var mesh : Mesh

func _pressed() -> void:
	target.mesh = mesh
	node.config.set_value(full_name, file_name, mesh)
	#ResourceSaver.save(mesh, "user://yes.cfg")
	node.config.save("user://char_data.cfg")
