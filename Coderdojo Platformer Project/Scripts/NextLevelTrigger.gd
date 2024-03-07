extends Area2D

@export var NextLevel : PackedScene
var changeScene = false

func _ready():
	#Connect singal for body entered, to local function _on_body_entered(), so when something hits enemys area2D, this function is called
	body_entered.connect(_on_body_entered)

#Handle enemy to other body collisions, in this case Player to enemy collisions
func _on_body_entered(body):
	#Get layer that collided with Area2D
	var layer = body.get_collision_layer()
	
	#if layer is player:
	if layer == 2:
		print("Player collided with next level trigger")
		changeScene = true

func _process(delta):
	if changeScene:	
		#Change to level2	
		get_tree().change_scene_to_packed(NextLevel)
