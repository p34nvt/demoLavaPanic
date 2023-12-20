extends Area2D

#This line initializes a variable called "spawner" as a reference to a node in the scene tree using the `get_node` function.
@onready var spawner: = get_tree().get_root().get_node("World/CanvasLayer/Spawner")

#Here, a variable called "audio" is initialized as a reference to another node in the scene tree.
@onready var audio = get_tree().get_root().get_node("World/Audio")

#These lines preload audio resources to be used later in the script.
var goutFloor = preload("res://audio/gout-floor.mp3")
var stepOnLava = preload("res://audio/step-on-lava.mp3")

#This line declares a boolean variable "splat" and initializes it to false.
var splat: bool = false

#This function is called when the node enters the scene tree and is ready to be used.
func _ready():


#Here, the `area_entered` signal of the current node is connected to the `_on_area_entered` function.
	self.area_entered.connect(_on_area_entered)

#This function is called when another Area or PhysicsBody enters the area of this node.
func _on_area_entered(area):


#This line checks if the entering area is in the "gout" group.
	if area.is_in_group("gout"):

#If the area is in the "gout" group, the `stream` property of the audio node is set to "goutFloor" and the audio is played.
		audio.stream = goutFloor
		audio.play()

#The `queue_free()` function is called on the entering area, which schedules it for deallocation.
		area.queue_free()

#These lines use `call_deferred` to call the "splash" and "throw_gout" functions on the "spawner" node after the current function has completed.
		spawner.call_deferred("splash")
		spawner.call_deferred("throw_gout")

