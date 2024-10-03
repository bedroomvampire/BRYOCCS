extends CharacterBody3D

@onready var anim_tree = $model/AnimationTree
@onready var model = $model
@onready var node = $Clothes

# Create new ConfigFile object.
var config = ConfigFile.new()

# Load data from a file.
var err = config.load("user://char_data.cfg")

var SPEED = 3.0
const walk = 3.334
const sprint = 5.001
const JUMP_VELOCITY = 4.5
var is_sprinting : bool

func _ready():
	clothes()
	colour()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("sprint"):
		SPEED = sprint
		is_sprinting = true
	else:
		SPEED = walk
		is_sprinting = false
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		model.global_rotation.y = lerp_angle(model.global_rotation.y, atan2(-velocity.x, -velocity.z), delta * 8)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	anim_tree.set("parameters/conditions/idle", !direction && is_on_floor())
	anim_tree.set("parameters/conditions/walk", direction && is_on_floor() && !is_sprinting)
	anim_tree.set("parameters/conditions/run", direction && is_on_floor() && is_sprinting)
	anim_tree.set("parameters/conditions/fall", !is_on_floor())
	move_and_slide()

func colour():
	node.colour(node.hair,0,config.get_value("Hair", "colour"))
	node.colour(node.hair2,0,config.get_value("Hair", "colour"))
	node.colour(node.glasses,0,config.get_value("Glasses", "frame"))
	node.colour(node.sunglasses,0,config.get_value("Glasses", "frame"))
	node.colour(node.jacket,0,config.get_value("Jacket", "colour"))
	node.colour(node.l_shirt,0,config.get_value("Shirt", "colour"))
	node.colour(node.s_shirt,0,config.get_value("Shirt", "colour"))
	node.colour(node.spandex,0,config.get_value("Spandex", "colour"))
	node.colour(node.trousers,0,config.get_value("Trouser", "colour"))
	node.colour(node.shorts,0,config.get_value("Trouser", "colour"))
	node.colour(node.body,2,config.get_value("Shoe", "colour"))

func clothes():
	if config.get_value("Hair", "length"):
		node.visible(node.hair, false)
		node.visible(node.hair2, true)
	else:
		node.visible(node.hair, true)
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
