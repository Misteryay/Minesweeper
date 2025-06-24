extends HBoxContainer

var flags: int 
var time: int  
@onready var timer: Timer = $Timer


func start() -> void:
	set_mouse_filter(MouseFilter.MOUSE_FILTER_IGNORE)
	
	var grid_manager = $"../../GridManager"
	
	time = 0
	timer.start()
	flags = grid_manager.total_mines
	set_flags()

	
func set_flags():
	
	$FlagsLabel.text = str("Flags: ", flags)


func _on_timer_timeout() -> void:
	time += 1
	$TimeLabel.text = str("Time: ", time)


func _on_grid_manager_game_over() -> void:
	timer.stop()
	$TimeLabel.add_theme_color_override("font_color", Color(255,0,0,1))
	$FlagsLabel.add_theme_color_override("font_color", Color(255,0,0,1))

func _on_grid_manager_game_win() -> void:
	timer.stop()
	$TimeLabel.add_theme_color_override("font_color", Color(0,255,0,1))
	$FlagsLabel.add_theme_color_override("font_color", Color(0,255,0,1))
