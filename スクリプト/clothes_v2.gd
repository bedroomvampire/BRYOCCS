extends Node

@export var name_label : Label3D
@export var info_label : Label3D
@export var body : MeshInstance3D
@export var back_hair : MeshInstance3D
@export var front_hair : MeshInstance3D
@export var mask : MeshInstance3D
@export var glasses : MeshInstance3D
@export var jacket : MeshInstance3D
@export var shirt : MeshInstance3D
@export var undershirt : MeshInstance3D
@export var skirt : MeshInstance3D
@export var gloves : MeshInstance3D
@export var spandex : MeshInstance3D
@export var trousers : MeshInstance3D

func visible(name,bool):
	name.visible = bool

func check(name,num : int):
	if name.get_surface_override_material(num):
		return true
	else:
		return false

func colour(name,mat,rgb : Color):
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(rgb.r,rgb.g,rgb.b)
	name.set_surface_override_material(mat,material)

func colour_alpha(name,mat,rgba : Color):
	var material = StandardMaterial3D.new()
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.albedo_color = Color(rgba.r,rgba.g,rgba.b,rgba.a)
	name.set_surface_override_material(mat,material)
