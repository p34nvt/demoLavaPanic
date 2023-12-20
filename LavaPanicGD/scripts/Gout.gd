extends Area2D
# Set the class_name to Gout and the constant SPEED to 100
class_name Gout
const SPEED = 100

# Call the _ready function when the script is ready
func _ready():
	# Enable the physics process
	set_physics_process(true)
	
# Define the behavior during the physics process
func _physics_process(delta):
	# Increase the position's y-coordinate based on the SPEED and delta time
	position.y += SPEED * delta
