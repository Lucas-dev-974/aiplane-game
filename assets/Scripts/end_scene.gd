extends Control

var destination = ["New York", "Miami", "San Francisco", "Los Angeles", "Saint-Denis", "Papeete"]
var destination_dist = [1000, 1500, 2000, 3000, 4000, 6000, 7000]
var reunion_texture = load("res://assets/mockup/destination/reunion.jpg")
func _ready() -> void:
	$BoxContainer/HBoxContainer/ScoreEnd.text = str(Global.score) + " KM"
	if Global.score >= destination_dist[0] && Global.score < destination_dist[1]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[0]
		$DestinationBackground.texture = load("res://assets/mockup/destination/newyork.jpg")
	elif Global.score >= destination_dist[1] && Global.score < destination_dist[2]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[1]
		$DestinationBackground.texture = load("res://assets/mockup/destination/miami.jpg")
	elif Global.score >= destination_dist[2] && Global.score < destination_dist[3]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[2]
		$DestinationBackground.texture = load("res://assets/mockup/destination/sanfrancisco.jpg")
	elif Global.score >= destination_dist[3] && Global.score < destination_dist[4]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[3]
		$DestinationBackground.texture = load("res://assets/mockup/destination/losangeles.jpg")
	elif Global.score >= destination_dist[4] && Global.score < destination_dist[5]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[4]
		$DestinationBackground.texture = load("res://assets/mockup/destination/reunion.jpg")
	elif Global.score >= destination_dist[5] && Global.score < destination_dist[6]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[5]
		$DestinationBackground.texture = load("res://assets/mockup/destination/tahiti.jpg")
		
	else:
		$BoxContainer/HBoxContainer2/Destination.text = "aucune destination."
		$DestinationBackground.texture = reunion_texture
		
	
func _on_btn_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scene/scene.tscn")
	
func _on_btn_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/interface/crédits.tscn")

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
