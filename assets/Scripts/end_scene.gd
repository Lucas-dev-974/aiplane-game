extends Control

func _ready() -> void:
	print("ok")
	$BoxContainer/HBoxContainer/ScoreEnd.text = str(Global.score)
	
	
func _on_btn_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scene/scene.tscn")


func _on_btn_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/interface/crédits.tscn")


func _on_btn_exit_pressed() -> void:
	get_tree().quit()
