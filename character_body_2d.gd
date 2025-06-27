extends CharacterBody2D

@onready var animatedsprite = $AnimatedSprite2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = Vector2(1, 0)
var health = 1



	
func _set_animation():
	if direction.x > 0: animatedsprite.flip_h = true
	elif direction.x < 0: animatedsprite.flip_h = false
	
