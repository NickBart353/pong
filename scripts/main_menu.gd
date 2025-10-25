extends Control

func _on_start_server_pressed() -> void:
	if NetworkHandler.start_server():
		NetworkHandler.load_game_scene()

func _on_start_client_pressed() -> void:
	if NetworkHandler.start_client():
		NetworkHandler.load_game_scene()

func _on_exit_pressed() -> void:
	get_tree().quit()
