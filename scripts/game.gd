extends Node2D

@export var ball_scene : PackedScene

signal goal_scored(goal)
var left_side_score
var right_side_score
var player_list : Array

@onready var PlayerSpawnPath = $PlayerSpawnPath

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
	update_score()
	reset_players()

func reset_game():
	left_side_score = 0
	right_side_score = 0
	reset_ball()

func reset_ball():
	var ball = ball_scene.instantiate()
	get_tree().current_scene.call_deferred("add_child", ball)

func update_score():
	$Control/LeftScore.text = "Score: {0}".format([left_side_score])
	$Control/RightScore.text = "Score: {0}".format([right_side_score])

func reset_players():
	player_list = PlayerSpawnPath.get_children()
	for player in player_list:
		player.reset_position()

func _on_button_pressed() -> void:
	pass
	#CHANGE SCENE TO MAIN MENU
