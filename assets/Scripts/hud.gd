extends Control

@onready var level = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@export var aiguille_1_rotate: Vector2 = Vector2(38, 0)
var auguille_degree: int = 38

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MSCadran/MSDisplay.text = str(Global.move_speed)
	
	$Control/Score.text = str(Global.score)
	if Global.fuel == 4:
		$Aiguille.rotation_degrees = 38
	if Global.fuel == 3:
		$Aiguille.rotation_degrees  = 19
	if Global.fuel == 2:
		$Aiguille.rotation_degrees  = 0
	if Global.fuel == 1:
		$Aiguille.rotation_degrees  = -19
	if Global.fuel == 0:
		$Aiguille.rotation_degrees  = -38
