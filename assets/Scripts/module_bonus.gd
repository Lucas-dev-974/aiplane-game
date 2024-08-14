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
	$BonusSoundEffect.play()
	on_percuted_bonus.emit()
	await delay_action(0.1)

# Coroutine qui attend le délai spécifié puis exécute l'action
func delay_action(seconds: float) -> void:
	# Attendre pendant le temps spécifié
	await get_tree().create_timer(seconds).timeout
	perform_action()

# Fonction qui contient l'action à exécuter
func perform_action() -> void:
	queue_free()
