extends Node3D

@export var module: Array[PackedScene] = [] 
@export var module_bonus: Array[PackedScene] = [] 
@export var hud_scene: PackedScene

var hud_instance
var damageVisual  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gmutils.resetParams()
	
	hud_instance = hud_scene.instantiate()
	damageVisual = hud_instance.find_child("DamageIndicator")
	damageVisual.visible = false
	
	Global.score = 0	
	
	# Instantiate timer
	TimersUtils_.InitiateScoreTimer()
	TimersUtils_.InitiateSpawnModuleTimer()
	#TimersUtils_.InitiateBlinkBloodTimer(hud_instance)
	
	add_child(TimersUtils_.scoreTimer)
	add_child(TimersUtils_.spawnModuleTimer)

	add_child(hud_instance)
	GenerateFirstModule()
	get_tree().paused = true


func ManageCloudSpawningInsteadOfMS():
	if Global.move_speed > 50:
		SpawnModule(Global.spawnAt, false)
		SpawnModule(Global.spawnAt, false)
	if Global.move_speed > 70:
		SpawnModule(Global.spawnAt, false)
	if Global.move_speed > 90:
		SpawnModule(Global.spawnAt, false)
		SpawnModule(Global.spawnAt, false)
	if Global.move_speed > 100:
		SpawnModule(Global.spawnAt, false)
		SpawnModule(Global.spawnAt, false)

func GenerateFirstModule():
	Global.started_game = true
	for n in Global.amount:
		if n >= 1:
			SpawnModule((n * Global.offset) * 2, false)	
	Global.firstIterationChids = gmutils.GetCloudHistory(self)



func _process(delta: float) -> void:
	if !gmutils.haveFuel():
		get_tree().change_scene_to_file("res://assets/interface/end_scene.tscn")
		return
	gmutils.inreasePlalier()



func SpawnModule(n, isBonusModule: bool, plusN = 0):
	var random = gmutils.GenerateRandomNumber(0, module.size() - 1)
	var instance
	
	if isBonusModule:
		instance = module_bonus[random].instantiate()
		instance.connect("on_percuted_bonus", gmutils.listened_percution_bonus)
	else:
		instance = module[random].instantiate()
		instance.connect("on_percuted_cloud", gmutils.listened_percution.bind(damageVisual))

	instance.position.x = n + plusN
	
	if Global.spawnTopModule:
		instance.position.y = 3
	
		
	Global.spawnTopModule = !Global.spawnTopModule
	add_child(instance)	
