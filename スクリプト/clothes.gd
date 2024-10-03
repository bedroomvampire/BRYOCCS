extends Node

@export var body : MeshInstance3D
@export var hair : MeshInstance3D
@export var hair2 : MeshInstance3D
@export var glasses : MeshInstance3D
@export var sunglasses : MeshInstance3D
@export var jacket : MeshInstance3D
@export var l_shirt : MeshInstance3D
@export var s_shirt : MeshInstance3D
@export var spandex : MeshInstance3D
@export var shorts : MeshInstance3D
@export var trousers : MeshInstance3D
@onready var test : MeshInstance3D

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func visible(name,bool):
	name.visible = bool

func colour(name,mat,rgb : Color):
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(rgb.r,rgb.g,rgb.b)
	name.set_surface_override_material(mat,material)
