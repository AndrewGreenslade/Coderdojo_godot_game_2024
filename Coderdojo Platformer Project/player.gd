extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite = $CollisionShape2D/AnimatedSprite2D

@export var lives = 3
@export var JumpMutiplier = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY * JumpMutiplier
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	sprite.flip_h = direction < 0
	
	if direction and lives > 0:
		velocity.x = direction * SPEED
		sprite.play("Walking")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("Idle")
		
	move_and_slide()
	
	if lives <= 0:
		sprite.visible = false
