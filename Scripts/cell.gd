extends Sprite2D

signal empty_cell(cell)
signal mine

var pressed : bool = false
var flagged: bool = false
var has_mine: bool = false
var mines_around: int = 0
var coordinates: Vector2 = Vector2.ZERO

func _ready() -> void:
	var grid_manager = get_parent()
	connect("empty_cell", Callable(grid_manager, "on_empty_cell"))
	connect("mine", Callable(grid_manager, "on_mine_exploded"))

func open_cell() -> void:
	if flagged or pressed:
		return
	
	if get_parent().is_first_interaction and (mines_around != 0 or has_mine):
		get_parent().re_open_cell(self)
		return
	
	if has_mine:

		var mine_texture = preload("res://Assets/Cell/mine.png")
		pressed = true
		emit_signal("mine")
		texture = mine_texture
		return
	
	var pressed_texture : Texture
	pressed = true
	get_parent().is_first_interaction = false
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


func flag_cell() -> void:
	
	if pressed:
		return
	if not flagged:
		print(self, " Flagged")
		get_parent().update_hud(-1)
		var flagged_texture = preload("res://Assets/Cell/flagged_cell.png")
		texture = flagged_texture
		flagged = true
		return
		
	var normal_texture = preload("res://Assets/Cell/normal_cell.png")
	texture = normal_texture
	get_parent().update_hud(1)
	flagged = false
	


func _on_control_gui_input(event: InputEvent) -> void:
	if pressed:
		return
		
	
	if event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
		open_cell()
	elif event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_RIGHT:
		flag_cell()
