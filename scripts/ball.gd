extends CharacterBody2D

var collision_data

func _ready():
	var random = randi_range(-1,1)
	while random == 0:
		random = randi_range(-1,1)
	velocity = Vector2(300 * random,0)
	global_position.x = 968.0
	global_position.y = 493.0

func _physics_process(delta):
	collision_data = move_and_collide(velocity * delta)
	if collision_data:
		velocity.y += randf_range(-200, 200)
		velocity = velocity.bounce(collision_data.get_normal())
