extends CanvasLayer

var started_game = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		if get_tree().paused:
			$Control.visible = false
			get_tree().paused = false
			
			if !started_game:
				started_game = true
		else:
			$Control.visible = true
			get_tree().paused = true


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	


func _on_continue_button_pressed() -> void:
	$Control.visible = false
	get_tree().paused = false
	if !started_game:
		started_game = true
