extends Area2D

func _on_body_entered(body):
	
	if body is main_player:
		body is main_player
		
		body.add_points(10)
		queue_free()
