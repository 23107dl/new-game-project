extends AudioStreamPlayer

func _process(delta):
	if Input.is_action_pressed("Jump"):
		$Jump.play()
