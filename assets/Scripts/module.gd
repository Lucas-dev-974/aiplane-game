extends Node3D

@onready var level = $".."

signal on_percuted_cloud
var speed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed = level.move_speed
	position.x -= speed * 0.016
	print("id:", self.get_instance_id(), "\n position x:", position.x, "\n score:",  Global.score)
	if position.x < -35: 	
		if position.y == 3:
			print("top spawn")
			level.spawn_top(position.x + (level.amount * level.offset))
		else:
			print("bottom spawn")
			level.spawnModule(position.x + (level.amount * level.offset))
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	$CloudPercutedSong.play()
	on_percuted_cloud.emit()
