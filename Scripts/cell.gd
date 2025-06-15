extends Sprite2D

var pressed : bool = false
var flagged: bool = false
var has_mine: bool = false
var mines_around: int

func open_cell() -> void:
	if flagged:
		return
	
	if has_mine:
		var mine_texture = preload("res://Assets/Cell/mine.png")
		texture = mine_texture
		return
	
	print(self, " pressed")
	var pressed_texutre = preload("res://Assets/Cell/pressed_cell.png")
	texture = pressed_texutre
	pressed = true

func flag_cell() -> void:
	
	if pressed:
		return
	if not flagged:
		print(self, " Flagged")
		var flagged_texture = preload("res://Assets/Cell/flagged_cell.png")
		texture = flagged_texture
		flagged = true
		return
		
	var normal_texture = preload("res://Assets/Cell/normal_cell.png")
	texture = normal_texture
	flagged = false


func _on_control_gui_input(event: InputEvent) -> void:
	if pressed:
		return
		
	
	if event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
		open_cell()
	elif event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_RIGHT:
		flag_cell()
