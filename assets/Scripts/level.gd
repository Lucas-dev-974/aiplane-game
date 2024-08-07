extends Node3D


@export var module: Array[PackedScene] = [] 

var amount = 2
var offset = 20
var fuel = 4
var score = 0

var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in amount:
		spawnModule(n * offset)	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fuel == 0:
		get_tree().change_scene_to_file("res://assets/scene/end_scene.tscn")
		return

func listened_percution():
	fuel -= 1
	print("percuted cloud, fuel at:", fuel)
	
func spawnModule(n):
	if fuel == 0:
		return
		
	rng.randomize()
	var num = rng.randi_range(0, module.size() - 1)
	var instance = module[num].instantiate()
	instance.connect("on_percuted_cloud", listened_percution)
	instance.position.x = n
	add_child(instance)
