extends Area2D

# Initialize the spawner and audio variables
var bucket_full: bool = false
var point: int = 0

var lava = preload("res://textures/lava.png")
var empty = preload("res://textures/empty.png")
var bucketFull = preload("res://audio/bucket-full.mp3")
var bucket = preload("res://audio/bucket.mp3")
var throwLava = preload("res://audio/throwlava.mp3")
var lifeUp = preload("res://audio/lifeup.mp3")

@onready var spawner = get_tree().get_root().get_node("World/CanvasLayer/Spawner")
@onready var character = get_tree().get_root().get_node("World/CanvasLayer/SteveCol")
@onready var audio = get_tree().get_root().get_node("World/Audio")

# Call the _ready function when the script is ready
func _ready():
	# Connect the area_entered signal to the _on_area_entered function
	self.area_entered.connect(_on_area_entered)
	# Connect the body_entered signal to the _on_body_entered function
	self.body_entered.connect(_on_body_entered)

# Define the behavior when the player enters an area
func _on_area_entered(area):
	# If the area is in the 'gout' group and the bucket is not full
	if area.is_in_group("gout") and not bucket_full:
		# Set the audio stream to the bucket audio file and play it
		audio.stream = bucket
		audio.play()
		# Increase the player's point and remove the area
		point += 1
		area.queue_free()
		# Call the throw_gout function from the spawner
		spawner.call_deferred("throw_gout")
		# Update the score text
	%Score.text = "Score: "+str(point)

# Define the behavior when the player's body enters an area
func _on_body_entered(body):
	# If the point is a multiple of 10 and the bucket is not full
	if point%10==0 and point!=0:
		if not bucket_full:
			# Set the audio stream to the bucketFull audio file and play it
			audio.stream = bucketFull
			audio.play()
			# Change the texture of the BucketSprite to lava
			$BucketSprite.texture = lava
		# Increase the player's point and set the bucket to be full
		point += 1
		bucket_full = true
	# If the body is in the 'wall' group and the bucket is full
	if body.is_in_group("wall") and bucket_full:
		# Set the audio stream to the throwLava audio file and play it
		audio.stream = throwLava
		audio.play()
		# Set the audio stream to the lifeUp audio file and play it
		audio.stream = lifeUp
		audio.play()
		# Change the texture of the BucketSprite to empty
		$BucketSprite.texture = empty
		# Set the player's health to 10 and set the bucket to be empty
		get_parent().get_parent().health = 10
		bucket_full = false
