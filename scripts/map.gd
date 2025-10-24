extends Node2D

@onready var game = get_parent()

func _on_left_border_body_entered(_body: Node2D) -> void:
	_update_score_and_reset_ball(_body, "left")

func _on_right_border_body_exited(_body: Node2D) -> void:
	_update_score_and_reset_ball(_body, "right")

func _update_score_and_reset_ball(_body, _left_or_right_goal):
	if _body.is_in_group("ball"):
		game.goal_scored.emit(_left_or_right_goal)
		_body.queue_free()
