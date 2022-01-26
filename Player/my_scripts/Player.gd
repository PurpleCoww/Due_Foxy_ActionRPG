extends KinematicBody2D


export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 120
export var FRICTION = 500


var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.LEFT


# set out states (variables that cannot change set to a specific value)
enum {
	MOVE,
	ROLL,
	ATTACK
}


# GET ACCESS TO CHILD NODE
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback") # get the playback property (inspector)
onready var swordHitbox = $HitboxPivot/SwordHitbox



#############
# FUNCTIONS #
#############


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ready!")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector



# This runs every single physics step
# Multiply with delta will normalize (real-world-timeing)
func _physics_process(delta):
	
	# DETERMIN THE STATE
	match state:
		MOVE: 
			move_state(delta)
		ATTACK:
			attack_state(delta)
		ROLL:
			roll_state(delta)




func move_state(delta):
	# MOVEMENT - vettori (0,0) 
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# Normalize diagonal movement 
	input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO: # when player move
		
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		
		# ANIMATIONS - get Animation Tree
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		
		# use Animation Tree
		animationState.travel("Run")
		
		# Allow move and collide
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	
	else: # when player dont move
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	
	move()
	
	
	# TRANSITION TO STATES
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL



# MOVEMENT
func move():
	velocity = move_and_slide(velocity)



# ATTACK
func attack_state(delta):
	velocity = Vector2.ZERO # fix - do not remember the velocity
	animationState.travel("Attack")
	
	
func attack_animation_finished():
	state = MOVE


# ROLL
func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()
	
	
func roll_animation_finished():
	velocity = Vector2.ZERO # fix roll sliding at the end of animation
	state = MOVE
