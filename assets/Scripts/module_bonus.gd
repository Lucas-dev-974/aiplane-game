extends Node3D

@onready var level = $".."

signal on_percuted_bonus
var speed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed = level.move_speed
	position.x -= speed * delta
	if position.x < -15:
		self.get_parent().spawnModule(position.x + (level.amount * level.offset))
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	on_percuted_bonus.emit()
	print("percuted cloud")
