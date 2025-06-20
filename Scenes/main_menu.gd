extends VBoxContainer


func _on_start_pressed() -> void:
	var probability_text: String = $ProbabilityInput.text
	var size_text: String = $GridInput.text
	
	var mine_probability : float = probability_text.to_float()
	var cuadratic_size: float  = size_text.to_float()
	
	var grid_manager = $"../GridManager"
	var hud = $"../HUD"

	if mine_probability == 0.0:
		mine_probability = 0.15
	if cuadratic_size == 0.0:
		cuadratic_size = 15

	grid_manager.cuadratic_size = cuadratic_size
	grid_manager.mine_probability = mine_probability
	
	grid_manager.start()
