extends Node3D

@onready var level = $".."

signal on_percuted_cloud
var speed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed = level.move_speed
	position.x -= speed * delta
	print("position y:", position.y)
	
	if position.x < -35: 	
		if position.y == 3:
			level.spawn_top(position.x + (level.amount * level.offset))
		else:
			level.spawnModule(position.x + (level.amount * level.offset))
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	$CloudPercutedSong.play()
	on_percuted_cloud.emit()
