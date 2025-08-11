extends CharacterBody2D

@onready var animatedsprite = $AnimatedSprite2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health = 1
var direction = 1

func _process(delta):
	if health <= 0:
		$CollisionShape2D.disabled = true
		set_physics_process(false)
		$AnimatedSprite2D.play("death")
	
func add_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
func move_enemy():
	velocity.x = SPEED * direction
	
func reverse_direction():
	if is_on_wall():
		direction = -direction
		
func _physics_process(delta: float) -> void:
	add_gravity(delta)
	move_enemy()
	move_and_slide()
	reverse_direction()
	
func _set_animation():
	if direction.x > 0: animatedsprite.flip_h = true
	elif direction.x < 0: animatedsprite.flip_h = false
	
	if health <= 0: animatedsprite.play("death")

		
func _on_animated_sprite_2d_animation_finished():
	if animatedsprite.animation == "death":
		queue_free()

func _on_get_damaged_body_entered(body):
	if body.name == "User_Player":
		health -= 1
