extends Sprite2D

signal empty_cell(cell)

var pressed : bool = false
var flagged: bool = false
var has_mine: bool = false
var mines_around: int = 0
var coordinates: Vector2 = Vector2.ZERO

func open_cell() -> void:
	if flagged:
		return
	
	if has_mine:
		var mine_texture = preload("res://Assets/Cell/mine.png")
		texture = mine_texture
		pressed = true
		return
	
	var pressed_texture : Texture 
	match mines_around:
		0:
			pressed_texture = preload("res://Assets/Cell/pressed_cell.png")
			emit_signal("empty_cell", self)
		1:
			pressed_texture = preload("res://Assets/Cell/1_mine.png")
		2:
			pressed_texture = preload("res://Assets/Cell/2_mines.png")
		3:
			pressed_texture = preload("res://Assets/Cell/3_mines.png")
		4:
			pressed_texture = preload("res://Assets/Cell/4_mines.png")
		5:
			pressed_texture = preload("res://Assets/Cell/5_mines.png")
		6:
			pressed_texture = preload("res://Assets/Cell/6_mines.png")
		7:
			pressed_texture = preload("res://Assets/Cell/7_mines.png")
		8:
			pressed_texture = preload("res://Assets/Cell/8_mines.png")
	
	texture = pressed_texture
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
