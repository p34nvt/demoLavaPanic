extends Marker2D

# Export variables for gout_scene and splash_scene.
@export var gout_scene : PackedScene
@export var splash_scene : PackedScene

# Reference to the root node and splash scene.
@onready var root = get_tree().get_root().get_node("World/CanvasLayer")
@onready var sp = splash_scene.instantiate()

# Variable to store the last x position.
var last_postion_x = 0

func _ready():
	
	# Set the initial y position.
	global_position.y = 128
	
	# Call the throw_gout function.
	throw_gout()
	
	if last_postion_x != 0:
		
		# Add the splash scene as a child to the root node after a delay.
		root.add_child.call_deferred(sp)

func throw_gout():
	
	# Set a random x position for the gout scene.
	global_position.x = 64 + 128 * randi_range(0, 8)
	
	# Instantiate the gout scene and add it as a child.
	var gt = gout_scene.instantiate()
	add_child.call_deferred(gt)
	
	# Store the current x position in last_postion_x variable.
	last_postion_x = global_position.x

func splash():
	
	if not sp.visible: sp.visible = true
	
	# Set the y position of the splash scene.
	sp.global_position.y = get_viewport_rect().size.y - 128
	
	# Set the x position of the splash scene to the last stored x position.
	sp.global_position.x = last_postion_x
