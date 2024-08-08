extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scene/scene.tscn")
	
func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_crédits_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/interface/crédits.tscn")
