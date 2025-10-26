class_name Player
extends CharacterBody2D

const SPEED = 10000.0
var direction

func _enter_tree():
	set_multiplayer_authority(int(str(name)))

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority(): return
	if Input.is_action_pressed("move_up"):
		direction = Vector2(0,-1)
	elif Input.is_action_pressed("move_down"):
		direction = Vector2(0,1)
	else:
		direction = Vector2.ZERO
	
	velocity = direction.normalized() * SPEED * delta
	
	move_and_slide()

func reset_position():
	pass
