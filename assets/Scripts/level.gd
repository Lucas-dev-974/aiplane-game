extends Node3D


@export var module: Array[PackedScene] = [] 
@export var module_bonus: Array[PackedScene] = [] 
@export var hud_scene: PackedScene


@export var move_speed = 20
var amount = 20
var offset = 15 
var fuel = 4
var rng = RandomNumberGenerator.new()
@export var spawnTopModule = false
var timer: Timer = null
var timer_spawn_bonus_module: Timer = null

var spawn_bonus_module = false

var started_game = false

var last_random = -1

var spawnModuleTimer: Timer
var spawnModuleBonusTimer: Timer

@export var apparitionTimeModule = 0.5
var firstIterationChids = []

func InitiateSpawnModuleTimer():
	spawnModuleTimer = Timer.new()
	spawnModuleTimer.wait_time = apparitionTimeModule # Temps en secondes entre chaque déclenchement
	spawnModuleTimer.autostart = true # Démarre automatiquement le spawnModuleTimer
	spawnModuleTimer.one_shot = false # Répéter à l'infini
	spawnModuleTimer.start()
	spawnModuleTimer.timeout.connect(onSpawnModuleTimer)

var lastPositionX = 0
var spawnAt = 200
var bonusCompteur = 0

# Fonction pour vérifier si un enfant avec un certain ID existe
func has_child_with_id(target_id: int) -> bool:
	for child in get_children():
		if child.get_instance_id() == target_id:  # Comparer l'ID avec le nom de l'enfant
			return true
	return false

func ManageCloudSpawningInsteadOfMS():
	if move_speed > 50:
		SpawnModule(spawnAt, false)
		SpawnModule(spawnAt, false)
	if move_speed > 70:
		SpawnModule(spawnAt, false)
	if move_speed > 90:
		SpawnModule(spawnAt, false)
		SpawnModule(spawnAt, false)
	if move_speed > 100:
		SpawnModule(spawnAt, false)
		SpawnModule(spawnAt, false)
		
func onSpawnModuleTimer():
	if has_child_with_id(firstIterationChids[14]):
		return
		
	# ------------------------------
	var spawnBonusModule: bool = false
	if bonusCompteur == 10:
		spawnBonusModule = true
		
	SpawnModule(spawnAt, spawnBonusModule)	 
	spawnBonusModule = true
	# ------------------------------
	
	ManageCloudSpawningInsteadOfMS()

	
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
	var hud_instance = hud_scene.instantiate()
	Global.score = 0
	# Score timer
	initiate_score_timer()
	InitiateSpawnModuleTimer()
	
	add_child(timer)
	add_child(spawnModuleTimer)
	add_child(hud_instance)
	GenerateFirstModule()
	get_tree().paused = true



var palier: int = 500
func GetCloudHistory(parent: Node) -> Array:
	var area3d_list = []
	for child in parent.get_children():
		if child is Area3D:
			area3d_list.append(child.get_instance_id())
	return area3d_list
	
func GenerateFirstModule():
	started_game = true
	for n in amount:
		if n >= 1:
			SpawnModule((n * offset) * 2, false)	
	firstIterationChids = GetCloudHistory(self)

func haveFuel():
	if fuel < 0:
		fuel = 0
	if fuel == 0:
		return false
	return true


func ManageCloudApparitionTimerFonctionToMS():
	match move_speed:
		var ms when ms == 20:
			apparitionTimeModule = 0.8
		var ms when ms == 30:
			apparitionTimeModule = 0.7
		var ms when ms == 40:
			apparitionTimeModule = 0.4
		var ms when ms == 60:
			apparitionTimeModule = 0.3
		var ms when ms == 80:
			apparitionTimeModule = 0.2
		var ms when ms == 100:
			apparitionTimeModule = 0
				
	if move_speed <= 100:	
		if Global.score >= palier:
			move_speed += 10
	else:
		apparitionTimeModule = 0 

# Plus il y a de move speed moin il nous faut de temps de réaparation 1/3 du temps précédent
func inreasePlalier():
	ManageCloudApparitionTimerFonctionToMS()
	if Global.score >= palier:
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

var last_pos_x = 0



func CountBonusApparition():
	if bonusCompteur == 10:
		bonusCompteur = 0
	bonusCompteur += 1
	
func SpawnModule(n, isBonusModule: bool, plusN = 0):
	CountBonusApparition()
	var random = GenerateRandomNumber(0, module.size() - 1)
	var instance
	
	if isBonusModule:
		instance = module_bonus[random].instantiate()
		instance.connect("on_percuted_bonus", listened_percution_bonus)
	else:
		instance = module[random].instantiate()
		instance.connect("on_percuted_cloud", listened_percution)

	instance.position.x = n + plusN
	
	if spawnTopModule:
		instance.position.y = 3
	
		
	spawnTopModule = !spawnTopModule
	add_child(instance)
	#instance_item_if_free(instance, Vector3(n, instance.position.y, instance.position.z))
	

func GenerateRandomNumber(min, max):
	rng.randomize()
	var random = rng.randi_range(min, max)
	if random == last_random:
		random = GenerateRandomNumber(min, max)
	return  random
	
