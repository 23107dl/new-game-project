extends Area2D

func _on_body_entered(body):
	if body.name == "User_Player":
		Global.has_key = true
		queue_free()
