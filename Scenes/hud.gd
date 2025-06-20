extends HBoxContainer

var flags: int 
var time: int  

func start() -> void:
	var grid_manager = $"../GridManager"
	time = 0
	$Timer.start()
	flags = grid_manager.total_mines
	set_flags()

	
func set_flags():
	
	$FlagsLabel.text = str("Flags: ", flags)


func _on_timer_timeout() -> void:
	time += 1
	$TimeLabel.text = str("Time: ", time)
