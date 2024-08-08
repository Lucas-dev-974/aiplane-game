extends Control

@onready var level = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@export var aiguille_1_rotate: Vector2 = Vector2(38, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$LabelFuel/Fuel.text = str(self.get_parent().fuel)
	$LabelScore/Score.text = str(Global.score)
	if self.get_parent().fuel == 4:
		$Aiguille.rotation_degrees  = 38
	if self.get_parent().fuel == 3:
		$Aiguille.rotation_degrees  = 38 - 19
	if self.get_parent().fuel == 3:
		$Aiguille.rotation_degrees  = 38 - (19*2)
	if self.get_parent().fuel == 3:
		$Aiguille.rotation_degrees  = 38 - (19*3)
