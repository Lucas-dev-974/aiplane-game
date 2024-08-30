extends Node
class_name GameUtils

var rng = RandomNumberGenerator.new()

func resetParams():
	Global.score = 0
	Global.apparitionTimeModule = 0.5
	Global.fuel = 4
	Global.move_speed = 20
	Global.firstIterationChids = []
	Global.palier = 500
	Global.bonusCompteur = 0
	Global.started_game = false
	pass
# Fonction pour vérifier si un enfant avec un certain ID existe
func has_child_with_id(target_id: int):
	var currentScene = get_tree().current_scene
	for child in currentScene.get_children():
		if child.get_instance_id() == target_id:  # Comparer l'ID avec le nom de l'enfant
			return true
	return false


func ManageCloudApparitionTimerFonctionToMS():
	match Global.move_speed:
		var ms when ms == 20:
			Global.apparitionTimeModule = 0.8
		var ms when ms == 30:
			Global.apparitionTimeModule = 0.7
		var ms when ms == 40:
			Global.apparitionTimeModule = 0.4
		var ms when ms == 60:
			Global.apparitionTimeModule = 0.3
		var ms when ms == 80:
			Global.apparitionTimeModule = 0.2
		var ms when ms == 100:
			Global.apparitionTimeModule = 0
				
	if Global.move_speed <= 100:	
		if Global.score >= Global.palier:
			Global.move_speed += 10
	else:
		Global.apparitionTimeModule = 0 

# Plus il y a de move speed moin il nous faut de temps de réaparation 1/3 du temps précédent
func inreasePlalier():
	ManageCloudApparitionTimerFonctionToMS()
	if Global.score >= Global.palier:
		
		Global.palier += 500
		
func haveFuel():
	if Global.fuel < 0:
		Global.fuel = 0
	if Global.fuel == 0:
		return false
	return true


func blinkVisualDamage(damageVisual):
	# Create a Timer dynamically in the script
	var timer = Timer.new()
	add_child(timer)  # Add the Timer as a child of this node
	timer.wait_time = 0.2  # Set the Timer's wait time to 1 second
	timer.one_shot = true  # Ensure the Timer stops after each timeout

	for i in range(6):
		
		damageVisual.visible = !damageVisual.visible  # Toggle visibility
		print("damage visible:", damageVisual.visible)
		timer.start()  # Start the Timer
		await timer.timeout  # Wait for the Timer's timeout signal

	timer.queue_free()  # Free the Timer after use
	
func listened_percution(damageVisual):
	blinkVisualDamage(damageVisual)
	Global.fuel -= 1
	
func listened_percution_bonus():
	if Global.fuel < 4:
		Global.fuel += 1

func CountBonusApparition():
	if Global.bonusCompteur == 10:
		Global.bonusCompteur = 0
	Global.bonusCompteur += 1
	
var last_random = -1
func GenerateRandomNumber(min, max):
	rng.randomize()
	var random = rng.randi_range(min, max)
	if random == last_random:
		random = GenerateRandomNumber(min, max)
	return  random
	

func GetCloudHistory(parent: Node) -> Array:
	var area3d_list = []
	for child in parent.get_children():
		if child is Area3D:
			area3d_list.append(child.get_instance_id())
	return area3d_list
