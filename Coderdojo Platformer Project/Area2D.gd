extends Area2D
@onready var player = $".." as main_player

func _on_body_entered(body):
	
	var layer = body.get_collision_layer()

	# If I hit an enemy Do this:
	if layer == 3:
		player.take_damage()
