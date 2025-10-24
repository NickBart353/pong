extends Node2D

@export var ball_scene : PackedScene

signal goal_scored(goal)
var left_side_score
var right_side_score

func _ready() -> void:
	reset_game()
	goal_scored.connect(_count_goal)

func _count_goal(goal):
	if goal == "left":
		right_side_score += 1
		print(goal, " ", right_side_score)
	elif goal == "right":
		left_side_score += 1
		print(goal, " ", left_side_score)
	reset_ball()

func reset_game():
	left_side_score = 0
	right_side_score = 0
	reset_ball()

func reset_ball():
	var ball = ball_scene.instantiate()
	add_child(ball)
