extends Node3D

@export var node : Node
@export var model : Node3D

# Create new ConfigFile object.
var config = ConfigFile.new()
var dolta : float

# Load data from a file.
var err = config.load("user://char_data.cfg")

@onready var blank_mesh = preload("res://モーデル/ノーマン/5C_A/メッシュ/empty.tres")
@onready var default_hair01 = preload("res://モーデル/ノーマン/5C_A/メッシュ/髪型/front_hair01.res")
@onready var default_hair02 = preload("res://モーデル/ノーマン/5C_A/メッシュ/髪型/back_hair01.res")
@onready var default_shirt = preload("res://モーデル/ノーマン/5C_A/メッシュ/シャツ/shirt01.res")
@onready var default_trousers = preload("res://モーデル/ノーマン/5C_A/メッシュ/ズボン/trouser.res")
@onready var default_skirt = preload("res://モーデル/ノーマン/5C_A/メッシュ/スカート/skirt.res")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#node.visible(node.hair2, false)
	#node.visible(node.glasses, false)
	#node.visible(node.sunglasses, false)
	#node.visible(node.jacket, false)
	#node.visible(node.l_shirt, false)
	#node.visible(node.spandex, false)
	#node.visible(node.trousers, false)
	
	# If the file didn't load, ignore it.
	if err != OK:
		reset_char()
	else:
		config.save("user://char_data.cfg")

func reset_char():
	config.clear()
	
	# Store default option values.
	config.set_value("Character", "name", "")
	config.set_value("Character", "info", "")
	config.set_value("Hair", "front_mesh", default_hair01)
	config.set_value("Hair", "back_mesh", default_hair02)
	config.set_value("Glasses", "visible", false)
	config.set_value("Mask", "visible", false)
	config.set_value("Jacket", "visible", false)
	config.set_value("Undershirt", "visible", false)
	config.set_value("Shirt", "visible", true)
	config.set_value("Shirt", "mesh", default_shirt)
	config.set_value("Trouser", "mesh", default_trousers)
	config.set_value("Trouser", "length", false)
	config.set_value("Skirt", "mesh", default_skirt)
	config.set_value("Spandex", "visible", false)
	
	# Store default colour values.
	config.set_value("Hair", "front_colour", Color(0,0,0))
	config.set_value("Hair", "back_colour", Color(0,0,0))
	config.set_value("Glasses", "frame", Color(0,0,0))
	config.set_value("Glasses", "lens", Color(1,1,1,.5))
	config.set_value("Mask", "colour", Color(0,0,0))
	config.set_value("Undershirt", "colour", Color(0,0,0))
	config.set_value("Shirt", "colour", Color(0,0,0))
	config.set_value("Shirt", "colour_2", Color(0,0,0))
	config.set_value("Shirt", "colour_3", Color(0,0,0))
	config.set_value("Shirt", "colour_4", Color(0,0,0))
	config.set_value("Jacket", "colour", Color(0,0,0))
	config.set_value("Jacket", "colour_2", Color(0,0,0))
	config.set_value("Jacket", "colour_3", Color(0,0,0))
	config.set_value("Jacket", "colour_4", Color(0,0,0))
	config.set_value("Skirt", "colour", Color(0,0,0))
	config.set_value("Trouser", "colour", Color(0,0,0))
	config.set_value("Trouser", "colour_2", Color(0,0,0))
	config.set_value("Spandex", "colour", Color(0,0,0))
	config.set_value("Sock", "colour", Color(0,0,0))
	config.set_value("Shoe", "colour", Color(0,0,0))
	config.set_value("Shoe", "colour_2", Color(0,0,0))
	
	# Save it to a file (overwrite if already exists).
	config.save("user://char_data.cfg")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.is_action_pressed("left_click"):
		#model.y += -event.relative.x * cam_sensitivity
		model.rotation.y += event.relative.x * dolta
	if Input.is_action_just_pressed("reset_char"):
		reset_char()

func _process(delta: float) -> void:
	dolta = delta
	set_label()
	set_mesh()
	show_hide()
	colour()

func colour():
	node.colour(node.front_hair,0,config.get_value("Hair", "front_colour"))
	node.colour(node.back_hair,0,config.get_value("Hair", "back_colour"))
	node.colour(node.glasses,0,config.get_value("Glasses", "frame"))
	node.colour_alpha(node.glasses,1,config.get_value("Glasses", "lens"))
	node.colour(node.mask,0,config.get_value("Mask", "colour"))
	node.colour(node.jacket,0,config.get_value("Jacket", "colour"))
	node.colour(node.jacket,1,config.get_value("Jacket", "colour_2"))
	node.colour(node.jacket,2,config.get_value("Jacket", "colour_3"))
	node.colour(node.jacket,3,config.get_value("Jacket", "colour_4"))
	node.colour(node.undershirt,0,config.get_value("Undershirt", "colour"))
	node.colour(node.skirt,0,config.get_value("Skirt", "colour"))
	node.colour(node.shirt,0,config.get_value("Shirt", "colour"))
	node.colour(node.shirt,1,config.get_value("Shirt", "colour_2"))
	node.colour(node.shirt,2,config.get_value("Shirt", "colour_3"))
	node.colour(node.shirt,3,config.get_value("Shirt", "colour_4"))
	node.colour(node.spandex,0,config.get_value("Spandex", "colour"))
	node.colour(node.trousers,0,config.get_value("Trouser", "colour"))
	#if config.get_value("Trouser", "colour_2"):
	#	node.colour(node.trousers,1,config.get_value("Trouser", "colour_2"))
	node.colour(node.body,4,config.get_value("Sock", "colour"))
	node.colour(node.body,5,config.get_value("Shoe", "colour"))
	node.colour(node.body,6,config.get_value("Shoe", "colour_2"))

func clothes():
	if config.get_value("Hair", "style") == "long":
		node.visible(node.hair, false)
		node.visible(node.hair2, true)
	elif config.get_value("Hair", "style") == "short":
		node.visible(node.hair, true)
		node.visible(node.hair2, false)
	else:
		node.visible(node.hair, false)
		node.visible(node.hair2, false)
	
	if config.get_value("Glasses", "glasses") == 2:
		node.visible(node.sunglasses, true)
		node.visible(node.glasses, false)
	elif config.get_value("Glasses", "glasses") == 1:
		node.visible(node.sunglasses, false)
		node.visible(node.glasses, true)
	else:
		node.visible(node.sunglasses, false)
		node.visible(node.glasses, false)
	
	if config.get_value("Jacket", "jacket"):
		node.visible(node.jacket, true)
	else:
		node.visible(node.jacket, false)
	
	if config.get_value("Spandex", "spandex"):
		node.visible(node.spandex, true)
	else:
		node.visible(node.spandex, false)
	
	if config.get_value("Shirt", "length"):
		node.visible(node.l_shirt, true)
		node.visible(node.s_shirt, false)
	else:
		node.visible(node.l_shirt, false)
		node.visible(node.s_shirt, true)
	
	if config.get_value("Trouser", "length"):
		node.visible(node.trousers, true)
		node.visible(node.shorts, false)
	else:
		node.visible(node.trousers, false)
		node.visible(node.shorts, true)

func set_label():
	node.name_label.text = config.get_value("Character", "name")
	node.info_label.text = config.get_value("Character", "info")

func set_mesh():
	node.front_hair.mesh = config.get_value("Hair", "front_mesh")
	node.back_hair.mesh = config.get_value("Hair", "back_mesh")
	node.shirt.mesh = config.get_value("Shirt", "mesh")
	node.trousers.mesh = config.get_value("Trouser", "mesh")
	node.skirt.mesh = config.get_value("Skirt", "mesh")

func show_hide():
	if config.get_value("Glasses", "visible"):
		node.visible(node.glasses, true)
	else:
		node.visible(node.glasses, false)
	
	if config.get_value("Jacket", "visible"):
		node.visible(node.jacket, true)
	else:
		node.visible(node.jacket, false)
	
	if config.get_value("Mask", "visible"):
		node.visible(node.mask, true)
	else:
		node.visible(node.mask, false)
		
	if config.get_value("Shirt", "visible"):
		node.visible(node.shirt, true)
	else:
		node.visible(node.shirt, false)
	
	if config.get_value("Undershirt", "visible"):
		node.visible(node.undershirt, true)
	else:
		node.visible(node.undershirt, false)
	
	if config.get_value("Spandex", "visible"):
		node.visible(node.spandex, true)
	else:
		node.visible(node.spandex, false)
	
	if config.get_value("Skirt", "visible"):
		node.visible(node.skirt, true)
	else:
		node.visible(node.skirt, false)
