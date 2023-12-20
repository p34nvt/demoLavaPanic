extends Node2D

#This line indicates that the current script extends the functionality of the Node2D class.
var world_scene = load("res://World.tscn")

#Here, a variable called "world_scene" is initialized to preload a scene file named "World.tscn".
func _ready():

#This function is called when the node enters the scene tree and is ready to be used.
	set_process(true)

#This line enables the `_process` function to be called every frame.
func _process(_delta):

#This function is called every frame to process the node's logic.
	if Input.get_action_strength("ui_accept") > 0:

#Here, it checks if the "ui_accept" action is being triggered. The `get_action_strength` function returns the strength of the named action.
		var w = world_scene.instantiate()

#If the "ui_accept" action is triggered, this line instantiates a new instance of the "world_scene" scene.
		get_tree().get_root().add_child(w)

#The newly created instance is added as a child of the root of the scene tree.
		queue_free()
