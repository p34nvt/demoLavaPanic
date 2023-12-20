extends CharacterBody2D
# Constants for speed and jump velocity.
const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# Variable for health.
var health: int = 10

# Get the default gravity from Project Settings.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Preload the heart scene.
@onready var heart_scene = preload("res://heart.tscn")

# Instantiate the heart scene.
@onready var heart = heart_scene.instantiate()

# Get references to Music and Audio nodes.
@onready var Music = get_tree().get_root().get_node("World/Music")
@onready var audio = get_tree().get_root().get_node("World/Audio")

# Preload the step and music audio files.
var step = preload("res://audio/step.mp3")
var music = preload("res://audio/Mellow_Ambient_Track.mp3")

func _ready():
	
	# Add the heart as a child to the parent node.
	get_parent().add_child.call_deferred(heart)
	
	# Set the initial position of the heart.
	heart.position = Vector2i(64, ceil(get_viewport_rect().size.y) - 64)
	
	# Enable physics process.
	set_physics_process(true)
	
	# Set the music stream and play it.
	Music.stream = music
	Music.play()
	
func _physics_process(delta):
	
	# Check if health is less than the number of hearts.
	if health < heart.get_child_count(false):
		
		heart.get_child(health).visible = false
		
	else:
		
		for h in heart.get_child_count(false):
			
			heart.get_child(h).visible = true
			
	# Calculate the direction based on input actions.
	var direction = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	
#If the direction is 0 (no input), set the character's horizontal velocity to 0 and stop the animation of the sprite.
	if direction == 0:
		velocity.x = 0
		$SteveSprite.stop()

#If the direction is not 0, check if the audio is not currently playing and if the current frame of the sprite is 1. If both conditions are met, set the audio stream to a step sound effect and play it.
	elif direction != 0:
		if not audio.playing and $SteveSprite.frame == 1:
			audio.stream = step
			audio.play()

#If the direction is greater than 0 (moving left), play the left animation of the sprite, set the position of a child node called "BucketCol" to -70 on the x-axis, and update the character's horizontal velocity based on the direction.
	if direction > 0:
		$SteveSprite.play("left")
		$SteveSprite/BucketCol.position.x = -70
		velocity.x -= direction * SPEED * delta

#If the direction is less than 0 (moving right), play the right animation of the sprite, set the position of "BucketCol" to 70 on the x-axis, and update the character's horizontal velocity based on the direction.
	elif direction < 0:
		$SteveSprite.play("right")
		$SteveSprite/BucketCol.position.x = 70
		velocity.x -= direction * SPEED * delta

#If the character is not on the floor (not grounded), increase its vertical velocity by applying gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

#If the "ui_up" input action is just pressed and the character is on the floor, set its vertical velocity to a predetermined jump velocity.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

#Move the character according to its velocity and handle collisions with the environment using the built-in move_and_slide function.
	move_and_slide()
