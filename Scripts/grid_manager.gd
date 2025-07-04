extends Node2D

signal game_lost
signal game_win

@export var cell_scene: PackedScene
@export var cuadratic_size: int = 3
@export var mine_probability: float = 0.20 # Values between 0 and 1. 1 meaning everything is a bomb

const CELL_WIDTH = 32
const CELL_HEIGHT = 32

var mines_grid: Array = []
var total_mines : int = 0
var cells_grid: Array = []
var is_first_interaction : bool = true

func start() -> void:
	total_mines = 0
	is_first_interaction = true
	clean_grid()
	center_grid()

	mines_grid.resize(cuadratic_size)
	for y in range(cuadratic_size):
		mines_grid[y] = []
		mines_grid[y].resize(cuadratic_size)
		
	cells_grid = generate_grid()
	add_random_bombs(cells_grid)
	get_grid_map(cells_grid)
	set_mines_around_cell(cells_grid)
	$"../Camera/HUD".start()
	print_grid()
	
	#print_grid()
	
func center_grid() -> void:
	position = ((Vector2(-CELL_WIDTH, -CELL_HEIGHT) * cuadratic_size) / 2)

func generate_grid() -> Array[Array]:
	var x_origin: int = 0
	var y_origin: int = 0
	var cells: Array[Array]
	
	for y in range(cuadratic_size):
		var cells_row: Array
		x_origin = 0
		
		for x in range(cuadratic_size):
			var new_cell = cell_scene.instantiate()
			new_cell.coordinates = Vector2(x, y)
			add_child(new_cell)
			new_cell.position.x = x_origin
			new_cell.position.y = y_origin
			x_origin += CELL_WIDTH
			cells_row.append(new_cell)
			connect("game_lost", Callable(new_cell, "on_game_over"))
		
		cells.append(cells_row)
		y_origin += CELL_HEIGHT
	return cells

func add_random_bombs(cells: Array[Array]) -> void:
	for row in range(cuadratic_size):
		for column in range(cuadratic_size):
			var rand_number = randf()
			if rand_number < mine_probability:
				var cell = cells[column][row]
				cell.has_mine = true
				total_mines += 1

func get_grid_map(cells: Array[Array]) -> void:
	for row in range(cuadratic_size):
		for column in range(cuadratic_size):
			var current_cell = cells[column][row]
			if current_cell.has_mine:
				mines_grid[column][row] = 1
			else:
				mines_grid[column][row] = 0

func set_mines_around_cell(cells: Array[Array]) -> void:
	for row in range(cuadratic_size):
		for column in range(cuadratic_size):
			var current_cell = cells[column][row]
			if current_cell.has_mine:
				continue
			
			var neighbour_cells = get_cell_neighbours(current_cell, cells)
			for neighbour in neighbour_cells:
				if neighbour.has_mine:
					current_cell.mines_around += 1

					
func get_cell_neighbours(cell, cells) -> Array:
	# Returns an array of the neighbors relative to that cell's position
	var current_cell_x = cell.coordinates.x
	var current_cell_y = cell.coordinates.y
	
	var neighbour_cells: Array = []
	for y in range(-1, 2):
		var neighbor_y = current_cell_y + y
		if neighbor_y < 0 or neighbor_y >= cuadratic_size:
			continue
		for x in range(-1, 2):
			var neighbor_x = current_cell_x + x
			if neighbor_x < 0 or neighbor_x >= cuadratic_size:
				continue
					
			var neighbor_cell = cells[neighbor_y][neighbor_x]
			if neighbor_cell.coordinates == cell.coordinates:
				continue
			neighbour_cells.append(neighbor_cell)
	return neighbour_cells

func print_grid() -> void:
	# Debug porpuses only
	# Prints the grid Array on console
	for y in range(cuadratic_size):
		var line := ""
		for x in range(cuadratic_size):
			line += "%d " % mines_grid[y][x]
		print(line.strip_edges())

func on_empty_cell(cell) -> void:
	var neighbours = get_cell_neighbours(cell, cells_grid)
	for neighbor in neighbours:
			neighbor.open_cell()

func on_mine_exploded() -> void:
	emit_signal("game_lost")
	for row in range(cuadratic_size):
		for column in range(cuadratic_size):
			var current_cell = cells_grid[column][row]
			if current_cell.has_mine:
				current_cell.flagged = false
				current_cell.open_cell()

func clean_grid() -> void:
	var cells = get_children()
	
	for cell in cells:
		cell.queue_free()

func re_open_cell(cell) -> void:
	# Used when the player opens a cell with a mine on his first move
	# Re generates the grid and opens again that cell
	start()
	cells_grid[cell.coordinates.y][cell.coordinates.x].open_cell()
	
func update_hud(n) -> void:
	var hud = $"../Camera/HUD"
	hud.flags += n
	hud.set_flags()
	if hud.flags == 0:
		check_win()

func check_win() -> void:
	var mines_uncovered : int = 0
	for y in range(cuadratic_size):
		for x in range(cuadratic_size):
			var current_cell = cells_grid[y][x]
			if current_cell.has_mine and not current_cell.flagged:
				mines_uncovered += 1
	print(mines_uncovered)
	if mines_uncovered > 0:
		return
	emit_signal("game_win")
	
