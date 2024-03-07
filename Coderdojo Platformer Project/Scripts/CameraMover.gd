extends Area2D

var main_Cam
@onready var move_towards = $CollisionShape2D

func _ready():
	main_Cam = get_viewport().get_camera_2d()

func _on_body_entered(body):
	if body is Main_Up_Down_Player:
		main_Cam.position = move_towards.position
