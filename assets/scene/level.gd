extends Node3D

@export var module: Array[PackedScene] = [] 

var amount = 10
var rng = RandomNumberGenerator.new()
var offset = 5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in amount:
		spawnModule(n*offset)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnModule(n):
	rng.randomize()
	var num = rng.randi_range(0, module.size() - 1)
	var instance = module[num].instantiate()
	instance.position.x = n
	add_child(instance)
