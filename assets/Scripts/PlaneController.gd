#extends CharacterBody3D
#
## Vitesse d'avancement automatique
#@export var speed : float = 5.0
#
## Vitesse de déplacement latéral
#@export var lateral_speed : float = 1.0
#
## Vitesse de rotation
#@export var rotation_speed : float = 1.0
#
#var cols = [-5, 0, 5]
#var col_index = 1
#
#func _ready():
	## Initialisation si nécessaire
	#pass
#
#func _physics_process(delta):
	## Définir la àvitesse de déplacement vers l'avant
	#velocity.z = speed
	## Déplacement vers la gauche (négatif sur l'axe X)
	#if Input.is_key_pressed(KEY_Q):
		#if col_index == 0:
			#col_index = 1
		#elif col_index == 1:
			#col_index = 2
		#else:
			#print("il n'est pas possible de tourner dans cet direction")
		#
		#position.x = cols[col_index]
		###rotation.z += rotation_speed * delta
		##velocity.x += lateral_speed
	#
	#if Input.is_key_pressed(KEY_D):
		#if col_index == 1:
			#col_index = 0
		#elif col_index == 2:
			#col_index = 1
		#else:
			#print("il n'est pas possible de tourner dans cet direction")
		#position.x = cols[col_index]
		##rotation.z -= rotation_speed * delta
		##velocity.x -= lateral_speed
#
	## Appliquer le déplacement en utilisant move_and_slide
	#move_and_slide()


extends CharacterBody3D

# Vitesse de déplacement automatique
@export var forward_speed : float = 5.0

# Vitesse de déplacement vertical (axe Y)
@export var vertical_speed : float = 2.0

# Colonnes prédéfinies sur l'axe X
@export var columns : Array = [-5.0, 0.0, 5.0]  # Exemple de colonnes X

# Vitesse de changement de colonne
@export var column_change_speed : float = 5.0

# Index de la colonne actuelle
var current_column_index : int = 0

func _ready():
	# Initialiser la colonne actuelle en fonction de la position initiale
	current_column_index = get_closest_column_index(global_transform.origin.x)
	print("current col index:", current_column_index)
	snap_to_column()

func _physics_process(delta):
	# Déplacement automatique vers l'avant
	velocity.z = forward_speed

	# Gestion des déplacements de colonne avec les touches
	if Input.is_action_just_pressed("ui_right"):
		print("ok right pressed")
		move_column(-1)
	elif Input.is_action_just_pressed("ui_left"):
		print("ok left pressed")
		move_column(1)

	# Appliquer le déplacement
	move_and_slide()
	
	# Déplacement vers la colonne cible
	if global_transform.origin.x != columns[current_column_index]:
		var target_position = columns[current_column_index]
		global_transform.origin.x = lerp(global_transform.origin.x, target_position, column_change_speed * delta)

func move_column(direction: int):
	# Calculer le nouvel index de colonne
	current_column_index = clamp(current_column_index + direction, 0, columns.size() - 1)
	
	# Assurer que la colonne cible est alignée correctement
	snap_to_column()

func snap_to_column():
	# Mettre à jour la position de l'avion pour se trouver sur la colonne actuelle
	global_transform.origin.x = columns[current_column_index]

func get_closest_column_index(x: float) -> int:
	# Trouver l'indice de la colonne la plus proche
	var closest_index : int = 0
	var min_distance : float = abs(x - columns[0])
	
	for i in range(1, columns.size()):
		var distance = abs(x - columns[i])
		if distance < min_distance:
			min_distance = distance
			closest_index = i
	
	return closest_index
