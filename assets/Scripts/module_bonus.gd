extends Node3D

@onready var level = $".."

signal on_percuted_bonus
var speed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= level.move_speed * delta

	if position.x < -30: 	
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	var soundPlayer = get_parent().find_child("BonusSoundEffect")
	soundPlayer.play()
	on_percuted_bonus.emit()
