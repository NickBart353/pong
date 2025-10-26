extends Node2D

@export var ball_scene : PackedScene
@export var player_scene : PackedScene

@onready var main_menu = $UI/MainMenu
@onready var hud = $UI/HUD

signal goal_scored(goal)
var left_side_score
var right_side_score
var player_list : Array[Player]
var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
var game_started = false

func _process(_delta: float) -> void:
	if $Players.get_children().size() == 2 and not game_started:
		game_started = true
		print("hello world")
		reset_game()

func _ready():
	$PlayerSpawner.spawn_function = add_player
	$BallSpawner.spawn_function = reset_ball
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
	reset_player_position()

func reset_game():
	left_side_score = 0
	right_side_score = 0
	reset_ball()
	reset_player_position()

func reset_ball():
	var ball = ball_scene.instantiate()
	#get_tree().current_scene.call_deferred("add_child", ball)
	add_child(ball, true)
	ball.global_position = $BallSpawnPoint/Marker2D.global_position

func update_score():
	$UI/HUD/LeftScore.text = "Score: {0}".format([left_side_score])
	$UI/HUD/RightScore.text = "Score: {0}".format([right_side_score])

func reset_player_position():
	for player in player_list:
		if player.name == "1":
			player.global_position = $PlayerSpawnPoints/PlayerOneSpawn.global_position
		else:
			player.global_position = $PlayerSpawnPoints/PlayerTwoSpawn.global_position

func _on_button_pressed() -> void:
	reset_game() # MAIN MENU

func _on_server_pressed() -> void:
	peer.create_server(25565)
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_connected.connect(
		func(pid):
			print("Player: {0} connected!".format([pid]))
			$PlayerSpawner.spawn(pid)
	)
	$PlayerSpawner.spawn(multiplayer.get_unique_id())
	main_menu.hide()
	hud.show()

func _on_client_pressed() -> void:
	peer.create_client("localhost", 25565)
	multiplayer.multiplayer_peer = peer
	main_menu.hide()
	hud.show()

func _on_exit_pressed() -> void:
	get_tree().quit()

func add_player(pid: int):
	var player = player_scene.instantiate()
	player.name = str(pid)
		
	if player.name == "1":
		player.global_position = $PlayerSpawnPoints/PlayerOneSpawn.global_position
	else:
		player.global_position = $PlayerSpawnPoints/PlayerTwoSpawn.global_position
		
	return player
