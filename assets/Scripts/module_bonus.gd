extends Node3D

@onready var level = $".."

signal on_percuted_bonus
var speed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("module id:", self.get_instance_id(), " : ", self.name)
	position.x -= level.move_speed * delta

	if position.x < -30: 	
		#level.SpawnModule(position.x + (level.amount * level.offset))
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	$BonusSoundEffect.play()
	on_percuted_bonus.emit()
