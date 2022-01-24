extends KinematicBody2D


const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ready!")


# This runs every single physics step
# Multiply with delta will normalize (real-world-timeing)
func _physics_process(delta):
	
	# MOVEMENT - vettori (0,0) 
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")	
	#print(input_vector)
	
	# Normalize diagonal movement 
	input_vector = input_vector.normalized()
	#print(input_vector)
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		#print(velocity)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		#print(velocity)
		
	# COLLISION
	# move_and_collide(velocity * delta)
	velocity = move_and_slide(velocity)
