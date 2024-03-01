extends CharacterBody2D
class_name main_player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite = $CollisionShape2D/AnimatedSprite2D as AnimatedSprite2D
@onready var livesLabel = $CanvasLayer/health as Label
@onready var scoreLabel = $CanvasLayer/score as Label

@onready var timer = $Timer as Timer

@export var lives = 3
@export var JumpMutiplier = 2
@export var points = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):

	
	sprite.flip_h = true
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and lives > 0:
		velocity.y = JUMP_VELOCITY * JumpMutiplier
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction and lives > 0:
		velocity.x = direction * SPEED
		sprite.play("Walking")
		sprite.flip_h = direction > 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("Idle")
		
	move_and_slide()

func take_damage():
	# take damage
	lives = lives - 1
		
	if lives <= 0:
		queue_free()
		
	livesLabel.text = "Lives: " + str(lives)
		
func add_health():
	lives = lives + 1
	
	livesLabel.text = "Lives: " + str(lives)

func add_points(value):
	points = points + value
	
	scoreLabel.text = "Score: " + str(points)
	
func go_invincible():
	timer.start()
	
	set_collision_layer_value(3, false)
	print("I AM A GOD")

func _on_timer_timeout():
	set_collision_layer_value(3, true)
	print("I AM A not a god GOD")
		
