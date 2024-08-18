extends Node3D

@onready var level = $".."

signal on_percuted_cloud
var firstDrop = false


var shape = SphereShape3D.new() 
var query = PhysicsShapeQueryParameters3D.new()
var result 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var space_state = get_world_3d().direct_space_state
	position.x -= level.move_speed * delta
	if position.x < -30: 	
		level.lastPositionX = position.x
		queue_free()
		return 
	
#
	#shape.radius = 0.5  # Ajustez la taille du rayon selon votre item
	#query.shape = shape
	#query.transform = Transform3D(Basis(), position)  # Définir la position pour la requête
	#query.collision_mask = 1  # Masque de collision si vous voulez filtrer certains objets
#
	## Effectuer le test de collision
	#result = space_state.intersect_shape(query, 1)
#
	#if result.size() != 0:
		#queue_free()
		
		
func _on_body_entered(body: Node3D) -> void:
	print("collision with:", body.name)
	$CloudPercutedSong.play()
	on_percuted_cloud.emit()


func _on_area_entered(area: Area3D) -> void:
	print("entereed")
	pass # Replace with function body.
