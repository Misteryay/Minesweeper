extends Node2D

@export var cell: PackedScene
@export var cuadratic_size: int = 3

const CELL_WIDTH = 32
const CELL_HEIGHT = 32



func _ready() -> void:
	position = (get_viewport_rect().size / 2) - ((Vector2(CELL_WIDTH, CELL_HEIGHT) * cuadratic_size) / 2)
	var cells: Array = generate_grid()
	add_random_bombs(cells)
	


func generate_grid() -> Array:
	var x_origin: int = 0
	var y_origin: int = 0
	var cells: Array = []
	
	for y in cuadratic_size:
		x_origin = 0
		for x in cuadratic_size:
			var new_cell = cell.instantiate()
			add_child(new_cell)
			new_cell.position.x = x_origin
			new_cell.position.y = y_origin
			x_origin += CELL_WIDTH
			cells.append(new_cell)
			
		y_origin += CELL_HEIGHT
	return cells

func add_random_bombs(cells: Array) -> void:
	for cell in cells:
		var random_number = randf()
		if random_number < 0.20:
			cell.has_mine = true
