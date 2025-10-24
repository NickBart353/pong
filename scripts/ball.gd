extends CharacterBody2D

var collision_data

func _ready():
	velocity = Vector2(300,0)
	global_position.x = 968.0
	global_position.y = 493.0

func _physics_process(delta):
	collision_data = move_and_collide(velocity * delta)
	if collision_data:
		velocity.y += randf_range(-200, 200)
		velocity = velocity.bounce(collision_data.get_normal())
