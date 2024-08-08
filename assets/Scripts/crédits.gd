extends Control

func _on_retour_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/interface/end_scene.tscn")
