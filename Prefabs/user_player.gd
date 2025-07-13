
extends CharacterBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -375.0
const WALL_SLIDING_SPEED = 2500

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var JumpsMade = 0
var DoWallJump = false
var start_position = Vector2(-15, 162)


func _physics_process(delta):
	var direction = Input.get_axis("move left", "move right")
	
	if is_on_wall_only(): velocity.y = WALL_SLIDING_SPEED * delta
	elif not is_on_floor(): velocity.y += gravity * delta
	else: JumpsMade = 0
	
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_wall_only():
			velocity.y = JUMP_VELOCITY
			velocity.x = -direction * SPEED
			DoWallJump = true
			$WallJumpTimer.start()
		elif is_on_floor() || JumpsMade < 1:
			velocity.y = JUMP_VELOCITY
			JumpsMade += 1
		
	if direction && not DoWallJump: velocity.x = direction * SPEED
	elif not DoWallJump: velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()


func _on_wall_jump_timer_timeout():
	DoWallJump = false
	
	#respawn
	if position.y > 900:
		respawn()

func respawn():
	position = start_position
