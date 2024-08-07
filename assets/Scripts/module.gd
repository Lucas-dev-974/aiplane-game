extends Node3D

@onready var level = $".."

signal on_percuted_cloud
var speed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed = self.get_parent().move_speed
	position.x -= speed * delta
	if position.x < -15:
		level.spawnModule(position.x + (level.amount * level.offset))
		queue_free()



func _on_body_entered(body: Node3D) -> void:
	on_percuted_cloud.emit()
	print("percuted cloud")
