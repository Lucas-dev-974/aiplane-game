extends Node3D


@export var module: Array[PackedScene] = [] 
@export var module_bonus: Array[PackedScene] = [] 

@export var hud_scene: PackedScene
var hud_instance: Node = null

var move_speed = 20
var amount = 10
var offset = 25
var fuel = 4
var rng = RandomNumberGenerator.new()

var timer: Timer = null
var timer_spawn_bonus_module: Timer = null

func on_timer_timeout():
	if move_speed != 0 && fuel > 0:
		Global.score +=  fuel

func initiate_score_timer():
	timer = Timer.new()
	timer.wait_time = 0.1 # Temps en secondes entre chaque déclenchement
	timer.autostart = true # Démarre automatiquement le timer
	timer.one_shot = false # Répéter à l'infini
	timer.start()
	timer.timeout.connect(on_timer_timeout)

var spawn_bonus_module = false

func on_timer_timeout_sawn_bonus():
	spawn_bonus_module = true

func initiate_module_bonus_timer():
	timer_spawn_bonus_module = Timer.new()
	timer_spawn_bonus_module.wait_time = 5 # Temps en secondes entre chaque déclenchement
	timer_spawn_bonus_module.autostart = true # Démarre automatiquement le timer_spawn_bonus_module
	timer_spawn_bonus_module.one_shot = false # Répéter à l'infini
	timer_spawn_bonus_module.start()
	timer_spawn_bonus_module.timeout.connect(on_timer_timeout_sawn_bonus)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.score = 0
	initiate_score_timer()
	initiate_module_bonus_timer()
	hud_instance = hud_scene.instantiate()
	add_child(timer_spawn_bonus_module)
	add_child(timer)
	add_child(hud_instance)
	get_tree().paused = true
	
var started_game = false

func startGame():
	started_game = true
	for n in amount:
		if n >= 1:
			print("iteration n:", n)
			spawnModule(n * offset)	
			spawn_top(n * offset)

var palier: int = 500

func haveFuel():
	if fuel < 0:
		fuel = 0
	if fuel == 0:
		return false
	return true

func inreasePlalier():
	if Global.score >= palier:
		move_speed += 10
		palier += 500
		
		
func _process(delta: float) -> void:
	if !haveFuel():
		get_tree().change_scene_to_file("res://assets/interface/end_scene.tscn")
		return
	inreasePlalier()

func listened_percution():
	fuel -= 1
	
func listened_percution_bonus():
	if fuel < 4:
		fuel += 1
	
func spawnModule(n):
	var instance = get_random_module()
	instance.connect("on_percuted_cloud", listened_percution)
	#instance.connect("on_percuted_bonus", listened_percution_bonus)
	instance.position.x = n
	add_child(instance)

func spawn_top(n):
	var instance_top = get_random_module_top()
	instance_top.connect("on_percuted_cloud", listened_percution)
	instance_top.position.y = 3
	instance_top.position.x = n 
	add_child(instance_top)
	
var last_random = -1

func GenerateRandomNumber(min, max):
	rng.randomize()
	var random = rng.randi_range(min, max)
	if random == last_random:
		random = GenerateRandomNumber(min, max)
	return  random
	
func get_random_module():
	rng.randomize()
	var instance
	var num = GenerateRandomNumber(0, module.size() - 1)
	var num_module_bonus = GenerateRandomNumber(0, module_bonus .size() - 1)

	last_random = num
		
	if !spawn_bonus_module:
		instance = module[num].instantiate()
	else:
		instance = module_bonus[num_module_bonus].instantiate()
	spawn_bonus_module = false
	return instance

func get_random_module_top():
	rng.randomize()
	var instance
	var num = GenerateRandomNumber(0, module.size() - 1)
	last_random = num
	instance = module[num].instantiate()
	instance.position.y = 3
	return instance
	
