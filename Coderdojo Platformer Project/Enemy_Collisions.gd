extends Area2D

func _on_body_entered(body):
	
	if body is main_player:
		body.take_damage()
