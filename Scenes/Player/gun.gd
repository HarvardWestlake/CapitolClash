extends CharacterBody3D

var sensitivity = 0.1
var gun_offset = Vector3()  # Initialize gun_offset as a Vector3
const ROTATION_SPEED = 10
var side_name = "right"
var rolling = false
var roll_timer = 0.5
var is_inverted = false

# Constants
const RAY_LENGTH = 1000
const BULLET_SPEED = 50 # Speed of the bullet
const BULLET_SCENE = preload("res://Scenes/Player/Bullet.tscn") # Path to the Bullet scene
var hand: CharacterBody3D
var origin
var cam
var intersects_with_floor = false

func _ready():
	hand = get_node_or_null("Node3D/Player/Hand")
	cam = $Camera3D

func set_gun_offset(offset: Vector3):
	gun_offset = offset

func _process(delta):

	var screen_size = get_viewport().get_visible_rect().size
	var mouse_position = get_viewport().get_mouse_position()

	# Calculate the direction vector from character to mouse
	var character_position = global_transform.origin + gun_offset
#	var character_position = transform.origin + gun_offset
	var target_direction = (mouse_position - screen_size / 2).normalized()

	# Calculate the angle between the current direction and the target direction
	var angle = atan2(target_direction.y, target_direction.x)
	if angle > -1.5708 and angle < 1.5708:
		side_name = "right"
	else:
		side_name = "left"
	switch(angle)

func switch(angle):
	if side_name == "left":
		scale.x = abs(scale.x)
		angle = -angle + 3.1415
		set_rotation(Vector3(0, 0, angle))
	elif side_name == "right":
		scale.x = -abs(scale.x)  # Flip the scale to negative
		scale.z = -scale.z
		set_rotation(Vector3(0, 0, -angle))