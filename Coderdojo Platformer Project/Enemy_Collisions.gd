extends Area2D

@export var hitTimer = 0.0
var timePerHit = 1.0
@export var hasHit = false

func _ready():
	#Connect singal for body entered, to local function _on_body_entered(), so when something hits enemys area2D, this function is called
	body_entered.connect(_on_body_entered)

#Handle enemy to other body collisions, in this case Player to enemy collisions
func _on_body_entered(body):
	#Get layer that collided with enemy
	var layer = body.get_collision_layer()
	
	#if layer is player and isnt in middle of hitting:
	if layer == 2 && hitTimer <= 0 and !hasHit:
		#Hit player code
		print("Enemy collided with: " + body.name)
		hasHit = true
		hitTimer = timePerHit
		body.lives -= 1

func _process(delta):
	#update hit timer
	if hasHit and hitTimer >= 0:
		hitTimer -= delta
		
	#reset is hitting bool
	if hasHit and hitTimer <= 0:
		hasHit = false
