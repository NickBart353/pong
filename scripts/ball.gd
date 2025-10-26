class_name Ball
extends CharacterBody2D

var collision_data

signal change_direction()

func _ready():
	change_direction.connect(pick_direction)
	if is_multiplayer_authority():
		pick_direction()

func _physics_process(delta):
	collision_data = move_and_collide(velocity * delta)
	if collision_data:
		velocity.y += randf_range(-200, 200)
		velocity = velocity.bounce(collision_data.get_normal())

func pick_direction():
	var random = randi_range(-1,1)
	while random == 0:
		random = randi_range(-1,1)
	velocity = Vector2(300 * random,0)
