extends Area2D


func _on_body_entered(body):
	if body.name == "User_Player":
		get_tree().change_scene_to_file("res://SCENES/level_2.tscn")
		
