extends Control


func _on_start_pressed() -> void:
	var probability_text: String = $VBoxContainer/ProbabilityInput.text
	var size_text: String = $VBoxContainer/GridInput.text
	
	var mine_probability : float = probability_text.to_float()
	var cuadratic_size: float  = size_text.to_float()
	
	if mine_probability == 0.0:
		mine_probability = 0.15
	if cuadratic_size == 0.0:
		cuadratic_size = 15

	get_parent().change_to_main_scene(cuadratic_size, mine_probability)


func _on_back_pressed() -> void:
	var main_menu : PackedScene = load("res://Scenes/main_menu.tscn")
	get_tree().change_scene_to_packed(main_menu)
