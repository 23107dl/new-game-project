extends CharacterBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound = $jump

const SPEED = 150.0
const JUMP_VELOCITY = -375.0
const WALL_SLIDING_SPEED = 1000

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var JumpsMade = 0
var DoWallJump = false
var start_position = Vector2(-15, 162)
var size_cloth = 100

func _ready() -> void:
	$Cloth.clear_points()

func _physics_process(delta):
	$Cloth.add_point(position)
	if $Cloth.get_point_count()>size_cloth:
		$Cloth.remove_point(0)
	var direction = Input.get_axis("move left", "move right")
	
	if is_on_wall_only(): velocity.y = WALL_SLIDING_SPEED * delta
	elif not is_on_floor(): velocity.y += gravity * delta
	else:
		if abs(velocity.x) > 10:
			anim.play("Run")
		else:
			anim.play("Idle")
			
		if velocity.x < 10:
			anim.flip_h = true
		else:
			anim.flip_h = false 
		
	
	
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_wall_only():
			velocity.y = JUMP_VELOCITY
			velocity.x = -direction * SPEED
			DoWallJump = true
			$WallJumpTimer.start()
		elif is_on_floor() || JumpsMade < 1:
			velocity.y = JUMP_VELOCITY
			JumpsMade += 1
			anim.play("Jump")
			jump_sound.play()
		
		
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


func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		respawn()
