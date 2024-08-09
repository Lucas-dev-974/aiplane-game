extends Control

@onready var level = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@export var aiguille_1_rotate: Vector2 = Vector2(38, 0)
var auguille_degree: int = 38
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Score.text = str(Global.score)
	
	if self.get_parent().fuel == 4:
		$CadranFuel/Aiguille.rotation_degrees  = 38
	if self.get_parent().fuel == 3:
		$CadranFuel/Aiguille.rotation_degrees  = 19
	if self.get_parent().fuel == 2:
		$CadranFuel/Aiguille.rotation_degrees  = 0
	if self.get_parent().fuel == 1:
		$CadranFuel/Aiguille.rotation_degrees  = -19
	if self.get_parent().fuel == 0:
		$CadranFuel/Aiguille.rotation_degrees  = -38
