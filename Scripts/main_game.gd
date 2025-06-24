extends Node

@onready var camera: Camera2D = $Camera
var toggle_camera : bool = false

func _on_exit_button_pressed() -> void:
	var main_menu : PackedScene = load("res://Scenes/main_menu.tscn")
	get_tree().change_scene_to_packed(main_menu)
	queue_free()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and toggle_camera:
		camera.position.x -= event.relative.x
		camera.position.y -= event.relative.y
		
	if event.is_action_pressed("mouse_wheel"):
		toggle_camera = !toggle_camera
		
