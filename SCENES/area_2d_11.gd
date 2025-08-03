extends Area2D


	


func _on_body_entered(body):
	if body.name == "User_Player":
		if Global.has_key == true:
			queue_free()
		else:
			body.respawn()
