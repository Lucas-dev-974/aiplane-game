extends Node3D


@export var module: Array[PackedScene] = [] 
@export var hud_scene: PackedScene
var hud_instance: Node = null

var move_speed = 20
var amount = 10
var offset = 25
var fuel = 4
var rng = RandomNumberGenerator.new()

var timer: Timer = null

func on_timer_timeout():
	if move_speed != 0:
		Global.score +=  fuel

func initiate_score_timer():
	timer = Timer.new()
	timer.wait_time = 0.1 # Temps en secondes entre chaque déclenchement
	timer.autostart = true # Démarre automatiquement le timer
	timer.one_shot = false # Répéter à l'infini
	timer.start()
	timer.timeout.connect(on_timer_timeout)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.score = 0
	
	initiate_score_timer()
	hud_instance = hud_scene.instantiate()
	add_child(timer)
	add_child(hud_instance)
	for n in amount:
		if n >= 1:
			spawnModule(n * offset)	
		
var last_move_speed: int = 0

func _input(event):
	# Vérifiez si la touche Échap a été pressée
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		# Basculez l'état de pause du jeu
		if move_speed != 0:
			last_move_speed = move_speed
			move_speed = 0
			print("in pause")
		else:
			print("out pause")
			move_speed = last_move_speed
			
	
var palier: int = 500
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fuel == 0:
		get_tree().change_scene_to_file("res://assets/interface/end_scene.tscn")
		return
	if Global.score >= palier:
		move_speed += 10
		palier += 500

func listened_percution():
	fuel -= 1
	
func listened_percution_bonus():
	if fuel < 4:
		fuel += 1
	
func spawnModule(n):
	if fuel == 0 && move_speed == 0:
		return
		
	var instance = get_random_module()
	
	instance.connect("on_percuted_cloud", listened_percution)
	instance.connect("on_percuted_bonus", listened_percution_bonus)
	instance.position.x = n
	add_child(instance)
	
func get_random_module():
	rng.randomize()
	var num = rng.randi_range(0, module.size() - 1)
	var instance = module[num].instantiate()
	return instance
	
