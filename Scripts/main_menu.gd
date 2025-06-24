extends Control


func _on_easy_button_pressed() -> void:
	change_to_main_scene(12, 0.20)


func _on_medium_button_pressed() -> void:
	change_to_main_scene(17, 0.20)


func _on_hard_button_pressed() -> void:
	change_to_main_scene(22, 0.20)

func change_to_main_scene(grid_size: int, probability: float) -> void:
	var main_game: PackedScene = preload("res://Scenes/main_game.tscn")
	var main_game_instance = main_game.instantiate()
	var grid = main_game_instance.get_node("GridManager")
	grid.cuadratic_size = grid_size
	grid.mine_probability = probability
	get_tree().get_root().add_child(main_game_instance)
	queue_free()
	grid.start()


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	var advanced_settings = preload("res://Scenes/advanced_settings.tscn").instantiate()
	add_child(advanced_settings)
	$VBoxContainer2.queue_free()
	$Exit.queue_free()
	
