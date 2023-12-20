extends Area2D
# Initialize the spawner and audio variables
@onready var spawner = get_tree().get_root().get_node("World/CanvasLayer/Spawner")
@onready var audio = get_tree().get_root().get_node("World/Audio")

# Load the loose and stepLava audio files
var loose_scene = preload("res://loose.tscn")
var stepLava = preload("res://audio/step-on-lava.mp3")
var damage = preload("res://audio/damage.mp3")

# Call the _ready function when the script is ready
func _ready():
	# Connect the area_entered signal to the _on_area_entered function
	self.area_entered.connect(_on_area_entered)

# Define the behavior when the player enters an area
func _on_area_entered(area):
	# If the area is in the 'gout' group
	if area.is_in_group("gout"):
		# Set the audio stream to the damage audio file and play it
		audio.stream = damage
		audio.play()
		# Decrease the player's health and remove the area
		get_parent().health -= 1
		area.queue_free()
		# Call the throw_gout function from the spawner
		spawner.throw_gout()
	# If the area is in the 'splash' group
	if area.is_in_group("splash"):
		# Decrease the player's health
		get_parent().health -= 1
		# Set the audio stream to the stepLava audio file and play it
		audio.stream = stepLava
		audio.play()
	# If the player's health is less than or equal to 0
	if get_parent().health <= 0:
		# Instantiate the loose_scene and add it to the scene tree
		var l = loose_scene.instantiate()
		get_tree().get_root().add_child(l)
		# Free the parent audio node
		audio.get_parent().queue_free()
