extends Node3D

@export var node : Node
@export var model : Node3D

# Create new ConfigFile object.
var config = ConfigFile.new()
var dolta : float

# Load data from a file.
var err = config.load("user://char_data.cfg")

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

func reset_char():
	config.clear()
	
	# Store default option values.
	config.set_value("Character", "name", "")
	config.set_value("Hair", "style", "short")
	config.set_value("Glasses", "glasses", 0)
	config.set_value("Jacket", "jacket", false)
	config.set_value("Shirt", "length", false)
	config.set_value("Trouser", "length", false)
	config.set_value("Spandex", "spandex", false)
	
	# Store default colour values.
	config.set_value("Hair", "colour", Color(0,0,0))
	config.set_value("Glasses", "frame", Color(0,0,0))
	config.set_value("Shirt", "colour", Color(0,0,0))
	config.set_value("Jacket", "colour", Color(0,0,0))
	config.set_value("Trouser", "colour", Color(0,0,0))
	config.set_value("Spandex", "colour", Color(0,0,0))
	config.set_value("Shoe", "colour", Color(0,0,0))
	
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
	clothes()
	colour()

func colour():
	node.colour(node.back_hair,0,config.get_value("Hair", "colour"))
	node.colour(node.front_hair,0,config.get_value("Hair", "colour"))
	node.colour(node.glasses,0,config.get_value("Glasses", "frame"))
	node.colour(node.jacket,0,config.get_value("Jacket", "colour"))
	node.colour(node.shirt,0,config.get_value("Shirt", "colour"))
	node.colour(node.spandex,0,config.get_value("Spandex", "colour"))
	node.colour(node.trousers,0,config.get_value("Trouser", "colour"))
	node.colour(node.body,5,config.get_value("Shoe", "colour"))
	node.colour(node.body,6,config.get_value("Shoe", "colour"))

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
